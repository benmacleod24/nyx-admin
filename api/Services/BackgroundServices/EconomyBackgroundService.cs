using api.Common.Constants;
using api.Models;
using api.Models.Game;
using Microsoft.EntityFrameworkCore;
using Quartz;

namespace api.Services.BackgroundServices
{
    public class EconomyBackgroundService : IJob
    {
        private readonly GameDataContext _gameContext;
        private readonly IServiceScopeFactory _scopeFactory;

        public EconomyBackgroundService(GameDataContext gameContext, IServiceScopeFactory scopeFactory)
        {
            _gameContext = gameContext;
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

                // Track total outstanding dollars.
                var totalOutstandingMetric = await TrackOutstandingDollars(_gameContext);
                _context.Metrics.Add(totalOutstandingMetric);

                // Track total dollars in the economy.
                var totalDollarsMetric = await TrackTotalDollars(_gameContext);
                _context.Metrics.Add(totalDollarsMetric);

                await _context.SaveChangesAsync();
            }
        }

        public async Task<Metric> TrackTotalDollars(GameDataContext _context)
        {
            var moneyList = _context.Players.Select(p => p.Money).ToList();
            var totalCash = moneyList.Sum(m => m.Cash);
            var totalPersonalBank = moneyList.Sum(m => m.Bank);
            var totalCrmBanks = await _context.CrmBankAccounts.SumAsync(a => a.CrmBalance);

            var totalDollars = totalCash + totalPersonalBank + totalCrmBanks;

            return new Metric
            {
                Key = MetricKeys.TotalDollars,
                Value = totalDollars
            };
        }

        private async Task<Metric> TrackOutstandingDollars(GameDataContext _context)
        {
            var loans = await _context.CrmBankLoans
                .Where(c => c.CrmRemaining > 0)
                .ToListAsync();

            var outstandingLoans = 0.0;

            foreach (CrmBankLoan loan in loans)
            {
                var totalPaid = (loan.CrmPayments - loan.CrmRemaining) * loan.CrmRecurring;
                var totalAmount = loan.CrmPayments * loan.CrmRecurring;
                outstandingLoans += (totalAmount - totalPaid);
            }

            return new Metric
            {
                Key = MetricKeys.TotalOutstandingDollars,
                Value = outstandingLoans
            };
        }
    }
}
