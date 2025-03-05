using api.DTOs.Request;
using api.DTOs.Response;
using api.Services.LogService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LogsController : ControllerBase
    {
        private readonly ILogService _logService;

        public LogsController(ILogService logService)
        {
            _logService = logService;
        }

        [HttpPost]
        public async Task<ActionResult> CreateLog(CreateLogDTO logData)
        {
            LogDTO log = await _logService.CreateLog(logData);
            return Ok(log);
        }

        [HttpGet]
        [Authorize]
        public async Task<ActionResult> GetAllLogs([FromQuery] PaginationRequestDTO paginationDetails)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null) return Unauthorized();

            PaginationResponseDTO<LogDTO> logs = await _logService.GetAllLogs(paginationDetails);
            return Ok(logs);
        }

        [HttpGet("{id}")]
        [Authorize]
        public async Task<ActionResult<LogDTO>> GetLogById(int id)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null) return Unauthorized();

            LogDTO log = await _logService.GetLogById(id);
            return Ok(log);
        }

        [HttpGet("metadata/keys")]
        [Authorize]
        public async Task<ActionResult<List<string>>> GetMetadataKeys()
        {
            return Ok(await _logService.GetMetadataKeys());
        }

        [HttpPost("search")]
        [Authorize]
        public async Task<ActionResult<PaginationResponseDTO<LogDTO>>> SearchLogs([FromBody] SearchLogsDTO request)
        {
            return Ok(await _logService.SearchLogs(request));
        }
    }
}
