using api.Common.Constants;
using api.Models;
using Microsoft.EntityFrameworkCore;

namespace api.Services.Reports.EconomyReportsService
{
    public class EconomyReportsService : IEconomyReportsService
    {
        private readonly DatabaseContext _context;

        public EconomyReportsService(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<EconomyCirculationReport>> GetTotalEconomyCirculationReport(DateTime start, DateTime end, string grouping)
        {
            // Query the last 30 days for the specific keys
            var metricsQuery = _context.Metrics
                .Where(m => m.Timestamp >= start && m.Timestamp <= end && (m.Key == MetricKeys.TotalDollars || m.Key == MetricKeys.TotalOutstandingDollars));

            IQueryable<IGrouping<object, Metric>> groupedMetrics;

            if (grouping == "hour")
            {
                groupedMetrics = metricsQuery
                    .GroupBy(m => new { m.Timestamp.Date, m.Timestamp.Hour }); // Group by hour
            }
            else if (grouping == "day")
            {
                groupedMetrics = metricsQuery
                    .GroupBy(g => new { g.Timestamp.Year, g.Timestamp.Month, g.Timestamp.Day }); // Group By Day
            } else
            {
                groupedMetrics = metricsQuery
                    .GroupBy(m => new { m.Timestamp.Year, m.Timestamp.Month }); // Group By Month
            }

            var metrics = await groupedMetrics
                .Select(m => new EconomyCirculationReport
                {
                    Date = m.Max(m => m.Timestamp),
                    TotalDollars = Math.Ceiling(m.Where(m => m.Key == MetricKeys.TotalDollars).OrderByDescending(m => m.Timestamp).First().Value),
                    TotalOutstandingDollars = Math.Ceiling(m.Where(m => m.Key == MetricKeys.TotalOutstandingDollars).OrderByDescending(m => m.Timestamp).First().Value)
                })
                .OrderBy(g => g.Date)
                .ToListAsync();

            return metrics;
                
        }
    }

    public class EconomyCirculationReport
    {
        public DateTime Date { get; set; }
        public double TotalDollars { get; set; }
        public double TotalOutstandingDollars { get; set; }
    }
}
