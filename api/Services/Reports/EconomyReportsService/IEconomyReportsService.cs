namespace api.Services.Reports.EconomyReportsService
{
    public interface IEconomyReportsService
    {
        public Task<List<EconomyCirculationReport>> GetTotalEconomyCirculationReport(int daysAgo);
    }
}
