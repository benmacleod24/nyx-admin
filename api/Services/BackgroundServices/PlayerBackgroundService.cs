using api.Common.Constants;
using api.Models;
using api.Models.Game;
using Microsoft.EntityFrameworkCore;
using Quartz;

namespace api.Services.BackgroundServices
{
    public class PlayerBackgroundService : IJob
    {
        private readonly IServiceScopeFactory _scopeFactory;

        public PlayerBackgroundService(IServiceScopeFactory scopeFactory)
        {  
          _scopeFactory = scopeFactory;
        }

        public async Task Execute(IJobExecutionContext context)
        {
            using (var scope = _scopeFactory.CreateScope())
            {
                // We should never update the game database here, unless plans change in the future.
                var _gameContext = scope.ServiceProvider.GetRequiredService<GameDataContext>();
                // The admin panel database, is what we save too.
                var _context = scope.ServiceProvider.GetRequiredService<DatabaseContext>();

                // Get the total number of unqiue players, unique by license.
                var totalUniquePlayers = GetUniquePlayerCountMetric(_gameContext);
                _context.Metrics.Add(totalUniquePlayers);

                // Total number of citizens with in the server.
                var totalCitizens = await GetCitizenCountMetric(_gameContext);
                _context.Metrics.Add(totalCitizens);

                await _context.SaveChangesAsync();
            }
        }

        private Metric GetUniquePlayerCountMetric(GameDataContext context)
        {
            var count = context.Players
                .ToList()
                .DistinctBy(x => x.License)
                .Count();

            return new Metric
            {
                Value = count,
                Key = MetricKeys.TotalUniquePlayers,
            };
        }

        private async Task<Metric> GetCitizenCountMetric(GameDataContext context)
        {
            var count = await context.Players
                .CountAsync();

            return new Metric
            {
                Value = count,
                Key = MetricKeys.TotalCitizens,
            };
        }
    }
}