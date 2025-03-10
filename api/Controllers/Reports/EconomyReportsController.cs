using api.Common;
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
        public async Task<ActionResult<List<EconomyCirculationReport>>> GetEconomyCiruclationReport(
            [FromQuery] string? range,
            [FromQuery] string? start,
            [FromQuery] string? end,
            [FromQuery] string grouping)
        {
            var timeRange = TimeRangeParser.ParseRange(range, start, end);
            if (timeRange == null)
                return BadRequest("Invalid range. Use formats like '24h', '7d', '2w', '3m', '1y' or specify custom 'start' and 'end' dates.");

            var report = await _economyReportService.GetTotalEconomyCirculationReport(timeRange.Value.Start, timeRange.Value.End, grouping);
            return Ok(report);
        }
    }
}
