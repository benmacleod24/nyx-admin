using api.Services.Reports.EconomyReportsService;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers.Reports
{
    [Route("api/reports/economy")]
    [ApiController]
    public class EconomyReportsController : ControllerBase
    {
        private readonly IEconomyReportsService _economyReportService;

        public EconomyReportsController(IEconomyReportsService economyReportService)
        {
            _economyReportService = economyReportService;
        }

        [HttpGet]
        public async Task<ActionResult<List<EconomyCirculationReport>>> GetEconomyCiruclationReport([FromQuery] int daysAgo)
        {
            return Ok(await _economyReportService.GetTotalEconomyCirculationReport(daysAgo));
        }
    }
}
