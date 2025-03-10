namespace api.Services.Reports.EconomyReportsService
{
    public interface IEconomyReportsService
    {
        public Task<List<EconomyCirculationReport>> GetTotalEconomyCirculationReport(DateTime start, DateTime end, string grouping);
    }
}
