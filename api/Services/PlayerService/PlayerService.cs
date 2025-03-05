using api.DTOs;
using api.DTOs.Request;
using api.DTOs.Response;
using api.Models.Game;
using api.Services.LogService;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace api.Services.CharacterService
{
    public class PlayerService : IPlayerService
    {
        private readonly GameDataContext _gameContext;
        private readonly IMapper _mapper;

        public PlayerService(GameDataContext gameContext, IMapper mapper)
        {
            _gameContext = gameContext;
            _mapper = mapper;
        }

        public async Task<PaginationResponseDTO<PlayerDTO>> SearchPlayers(SearchPlayersDTO request)
        {
            IEnumerable<Player> playerQuery = _gameContext.Players;

            playerQuery = BuildPlayerFilters(playerQuery, request.Filters);

            if (request.SortBy != null)
            {
                playerQuery = request.SortOrder.ToLower() == "desc"
                    ? playerQuery.OrderByDescending(GetSortProperty(request.SortBy).Compile())
                    : playerQuery.OrderBy(GetSortProperty(request.SortBy).Compile());
            }

            List<Player> players = playerQuery
                .Skip((request.Page - 1) * request.Size)
                .Take(request.Size)
                .ToList();

            int totalPlayersInQuery = playerQuery.Count();

            return new PaginationResponseDTO<PlayerDTO>
            {
                Items = _mapper.Map<List<PlayerDTO>>(players),
                TotalPages = (int)Math.Ceiling((decimal)totalPlayersInQuery / (decimal)request.Size)
            };
        }

        public async Task<PlayerDTO?> GetPlayerByCitizenId(string citizenId)
        {
            Player? player = await _gameContext.Players
                .Where(p => p.Citizenid == citizenId)
                .SingleOrDefaultAsync();

            return _mapper.Map<PlayerDTO?>(player);
        }

        private IEnumerable<Player> BuildPlayerFilters(IEnumerable<Player> query, List<SearchFilter> filters)
        {
            if (filters == null || filters.Count == 0)
                return query; // No filters, return all records

            ParameterExpression param = Expression.Parameter(typeof(Player), "x");
            Expression finalExpression = null;

            foreach (var filter in filters)
            {
                Expression propertyExpression = GetNestedPropertyExpression(param, filter.Key);
                if (propertyExpression == null)
                    throw new InvalidOperationException($"Field '{filter.Key}' does not exist in {typeof(Player).Name}");

                Type propertyType = propertyExpression.Type;
                object typedValue;
                try
                {
                    typedValue = Convert.ChangeType(filter.Value, propertyType);
                }
                catch (Exception)
                {
                    throw new InvalidOperationException($"Cannot convert value '{filter.Value}' to type {propertyType.Name}");
                }

                Expression right = Expression.Constant(typedValue, propertyType);

                Expression? comparison = filter.Operator switch
                {
                    "==" => Expression.Equal(propertyExpression, right),
                    "!=" => Expression.NotEqual(propertyExpression, right),
                    ">" when IsComparable(propertyType) => Expression.GreaterThan(propertyExpression, right),
                    ">=" when IsComparable(propertyType) => Expression.GreaterThanOrEqual(propertyExpression, right),
                    "<" when IsComparable(propertyType) => Expression.LessThan(propertyExpression, right),
                    "<=" when IsComparable(propertyType) => Expression.LessThanOrEqual(propertyExpression, right),
                    "contains" => propertyExpression.Type == typeof(string) ? Expression.Call(propertyExpression, "Contains", null, right) : Expression.Call(Expression.Call(propertyExpression, "ToString", null), "Contains", null, Expression.Call(right, "ToString", null)),
                    _ => null
                };

                if (comparison == null)
                    continue;

                // Combine expressions using AND
                finalExpression = finalExpression == null ? comparison : Expression.AndAlso(finalExpression, comparison);
            }

            // Compile expression into a delegate
            var lambda = Expression.Lambda<Func<Player, bool>>(finalExpression ?? Expression.Constant(true), param).Compile();

            return query.AsEnumerable().Where(lambda);
        }

        private Expression<Func<Player, object>> GetSortProperty(string sortBy)
        {
            ParameterExpression param = Expression.Parameter(typeof(Player), "x");

            // Use GetNestedPropertyExpression to retrieve the sorting field dynamically
            Expression propertyExpression = GetNestedPropertyExpression(param, sortBy);

            // Convert to object (boxing)
            UnaryExpression converted = Expression.Convert(propertyExpression, typeof(object));

            return Expression.Lambda<Func<Player, object>>(converted, param);
        }

        private Expression GetNestedPropertyExpression(Expression param, string fieldPath)
        {
            string[] fields = fieldPath.Split('.');
            Expression propertyExpression = param;

            foreach (var field in fields)
            {
                var propertyInfo = propertyExpression.Type.GetProperty(field, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                if (propertyInfo == null)
                    throw new InvalidOperationException($"Field '{fieldPath}' does not exist in {propertyExpression.Type.Name}");

                propertyExpression = Expression.Property(propertyExpression, propertyInfo);
            }

            return propertyExpression;
        }

        // Determine if the type is of a number so we can do <, <=, >, >=
        private bool IsComparable(Type type)
        {
            return type == typeof(int) || type == typeof(double) || type == typeof(float) ||
                   type == typeof(decimal) || type == typeof(long) || type == typeof(short) ||
                   type == typeof(byte) || type == typeof(DateTime) || type == typeof(TimeSpan);
        }
    }
}
