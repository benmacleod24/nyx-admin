using api.DTOs;
using api.DTOs.Request;
using api.DTOs.Response;
using api.Models;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using System.Reflection;
using System.Text.Json;

namespace api.Services.LogService
{
    public class LogService : ILogService
    {
        private readonly DatabaseContext _context;
        private readonly IMapper _mapper;

        public LogService(DatabaseContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<LogDTO> CreateLog(CreateLogDTO log)
        {
            Log _log = new Log
            {
                Level = log.Level,
                Message = log.Message,
            };
            Console.WriteLine(log.Metadata.GetType().Name);

            if (log.Metadata != null)
            {
                foreach (var entry in log.Metadata)
                {
                    
                    if (entry.Value == null)
                    {
                        continue;
                    }

                    LogMetadataEntry metadataEntry = new LogMetadataEntry
                    {
                        Key = entry.Key,
                        Value = JsonSerializer.Serialize(entry.Value),
                    };

                    _log.Metadata.Add(metadataEntry);
                }
            }

            _context.Logs.Add(_log);
            await _context.SaveChangesAsync();

            return _mapper.Map<LogDTO>(_log);
        }

        public async Task<PaginationResponseDTO<LogDTO>> GetAllLogs(PaginationRequestDTO paginationRequest)
        {
            int totalNumberOfLogs = await _context.Logs.CountAsync();

            IEnumerable<Log> logs = await _context.Logs
                .Skip((paginationRequest.Page - 1) * paginationRequest.Size)
                .Take(paginationRequest.Size)
                .Include(log => log.Metadata)
                .ToListAsync();

            return new PaginationResponseDTO<LogDTO>
            {
                Items = _mapper.Map<List<LogDTO>>(logs),
                TotalPages = (int)Math.Ceiling((double)totalNumberOfLogs / paginationRequest.Size),
            };

        }

        public async Task<LogDTO> GetLogById(int id)
        {
            Log? log = await _context.Logs
                .Include(l => l.Metadata)
                .Where(l => l.Id == id)
                .FirstOrDefaultAsync();

            return _mapper.Map<LogDTO>(log);
        }

        public async Task<List<string>> GetMetadataKeys()
        {
            return await _context.LogMetadataEntries
                .Select(e => e.Key)
                .Distinct()
                .ToListAsync();
        }

        public async Task<PaginationResponseDTO<LogDTO>> SearchLogs(SearchLogsDTO searchRequest)
        {
            IQueryable<Log> query = _context.Logs.Include(log => log.Metadata);

            query = BuildLogFilters(query, searchRequest.Filters);

            var items = await query
                .Where(l => l.CreatedAt >= searchRequest.StartTime && l.CreatedAt <= searchRequest.EndTime)
                .OrderByDescending(l => l.CreatedAt)
                .Skip((searchRequest.Page - 1) * searchRequest.Size)
                .Take(searchRequest.Size)
                .ToListAsync();

            int totalItems = await query
                .Where(l => l.CreatedAt >= searchRequest.StartTime && l.CreatedAt <= searchRequest.EndTime)
                .CountAsync();

            return new PaginationResponseDTO<LogDTO>
            {
                Items = _mapper.Map<List<LogDTO>>(items),
                TotalPages = (int)Math.Ceiling((decimal)totalItems / (decimal)searchRequest.Size),
            };
        }

        private IQueryable<Log> BuildLogFilters(IQueryable<Log> query, IEnumerable<SearchFilter> filters)
        {
            if (!filters.Any())
                return query;

            // Group filters by key
            var groupedFilters = filters.GroupBy(f => f.Key);

            Expression<Func<Log, bool>>? finalExpression = null;

            foreach (var group in groupedFilters)
            {
                var parameter = Expression.Parameter(typeof(Log), "log");
                Expression? groupExpression = null;

                foreach (var filter in group)
                {
                    Expression condition;

                    if (typeof(Log).GetProperty(filter.Key) != null)
                    {
                        Expression property = typeof(Log).GetProperty(filter.Key) == null
                            ? BuildMetadataFilter(parameter, filter)
                            : Expression.Property(parameter, filter.Key);

                        object parsedValue = Convert.ChangeType(filter.Value, property.Type);
                        Expression constant = Expression.Constant(parsedValue);

                        switch (filter.Operator.ToLower())
                        {
                            case "equals":
                                condition = Expression.Equal(property, constant);
                                break;
                            case "notequals":
                                condition = Expression.NotEqual(property, constant);
                                break;
                            case "contains":
                                if (property.Type == typeof(string))
                                {
                                    condition = Expression.Call(property, "Contains", null, constant);
                                    break;
                                }
                                else
                                {
                                    var propertyAsString = Expression.Call(property, "ToString", null);
                                    var valueAsString = Expression.Call(constant, "ToString", null);
                                    condition = Expression.Call(propertyAsString, "Contains", null, valueAsString);
                                    break;
                                }

                            default:
                                throw new NotSupportedException($"Unsupported Operator: {filter.Operator}");
                        }
                    }
                    else
                    {
                        condition = BuildMetadataFilter(parameter, filter);
                    }

                    groupExpression = groupExpression == null
                        ? condition
                        : Expression.OrElse(groupExpression, condition);
                }

                var groupLambda = Expression.Lambda<Func<Log, bool>>(groupExpression!, parameter);
                finalExpression = finalExpression == null
                    ? groupLambda
                    : CombineWithAnd(finalExpression, groupLambda);
            }

            return query.Where(finalExpression);
        }

        private Expression BuildMetadataFilter(ParameterExpression parameter, SearchFilter filter)
        {
                // Access the Metadata property (ICollection<LogMetadataEntry>)
                var metadataProperty = Expression.Property(parameter, nameof(Log.Metadata));

                // Create a parameter for the LogMetadataEntry
                var metadataParameter = Expression.Parameter(typeof(LogMetadataEntry), "m");

                // Access the Key and Value properties in LogMetadataEntry
                var keyProperty = Expression.Property(metadataParameter, nameof(LogMetadataEntry.Key));
                var valueProperty = Expression.Property(metadataParameter, nameof(LogMetadataEntry.Value));

                // Ensure both the filter and the property are treated as strings
                var keyCondition = Expression.Equal(
                    keyProperty,
                    Expression.Constant(filter.Key, typeof(string)) // Treat as string
                );

                // Handle the Value condition using a switch
                Expression valueCondition;
                switch (filter.Operator.ToLower())
                {
                    case "equals":
                        valueCondition = Expression.Equal(
                            valueProperty,
                            Expression.Constant(filter.Value, typeof(string)) // Treat as string
                        );
                        break;
                case "notequals":
                    valueCondition = Expression.NotEqual(
                        valueProperty,
                        Expression.Constant(filter.Value, typeof(string)) // Treat as string
                    );
                    break;
                case "contains":
                        valueCondition = Expression.Call(
                            valueProperty,
                            typeof(string).GetMethod("Contains", new[] { typeof(string) })!,
                            Expression.Constant(filter.Value, typeof(string)) // Treat as string
                        );
                        break;
                    default:
                        throw new NotSupportedException($"Operator '{filter.Operator}' is not supported.");
                }

                // Combine Key and Value conditions with AND
                var metadataCondition = Expression.AndAlso(keyCondition, valueCondition);

                // Build a lambda: m => m.Key == filter.Key AND m.Value == filter.Value
                var metadataLambda = Expression.Lambda<Func<LogMetadataEntry, bool>>(
                    metadataCondition, metadataParameter
                );

                // Apply .Any() on the Metadata collection
                return Expression.Call(
                    typeof(Enumerable),
                    "Any",
                    new[] { typeof(LogMetadataEntry) },
                    metadataProperty,
                    metadataLambda
                );
            }

        private Expression<Func<T, bool>> CombineWithAnd<T>(
            Expression<Func<T, bool>> expr1,
            Expression<Func<T, bool>> expr2
        )
        {
            var parameter = Expression.Parameter(typeof(T));

            var leftVisitor = new ReplaceParameterVisitor(expr1.Parameters[0], parameter);
            var left = leftVisitor.Visit(expr1.Body);

            var rightVisitor = new ReplaceParameterVisitor(expr2.Parameters[0], parameter);
            var right = rightVisitor.Visit(expr2.Body);

            var body = Expression.AndAlso(left, right);
            return Expression.Lambda<Func<T, bool>>(body, parameter);
        }

    }

    public class ReplaceParameterVisitor : ExpressionVisitor
    {
        private readonly ParameterExpression _oldParameter;
        private readonly ParameterExpression _newParameter;

        public ReplaceParameterVisitor(ParameterExpression oldParameter, ParameterExpression newParameter)
        {
            _oldParameter = oldParameter;
            _newParameter = newParameter;
        }

        protected override Expression VisitParameter(ParameterExpression node)
        {
            return node == _oldParameter ? _newParameter : base.VisitParameter(node);
        }
    }
}
