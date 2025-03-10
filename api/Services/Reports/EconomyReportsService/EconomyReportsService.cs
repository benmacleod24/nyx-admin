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

        public async Task<List<EconomyCirculationReport>> GetTotalEconomyCirculationReport(int daysAgo = 1)
        {
            DateTime startDate = DateTime.UtcNow.AddDays(-daysAgo);

            // Query the last 30 days for the specific keys
            var metricsQuery = _context.Metrics
                .Where(m => m.Timestamp >= startDate && (m.Key == MetricKeys.TotalDollars || m.Key == MetricKeys.TotalOutstandingDollars));

            IQueryable<IGrouping<object, Metric>> groupedMetrics;

            // If the date range is less than or equal to 1 day, group by hour only
            if (daysAgo <= 1)
            {
                groupedMetrics = metricsQuery
                    .GroupBy(m => new { m.Timestamp.Date, m.Timestamp.Hour }); // Group by hour
            }
            // If the date range is between 1 and 30 days, group by day
            else if (daysAgo <= 30)
            {
                groupedMetrics = metricsQuery
                    .GroupBy(m => new { m.Timestamp.Date }); // Group by full date (day)
            }
            // If the date range exceeds 30 days, group by month
            else
            {
                groupedMetrics = metricsQuery
                    .GroupBy(m => new { m.Timestamp.Year, m.Timestamp.Month }); // Group by year and month
            }

            var metrics = await groupedMetrics
                .Select(m => new EconomyCirculationReport
                {
                    Date = m.First().Timestamp,
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
