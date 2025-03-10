using api.DTOs.Request;
using api.DTOs.Response;
using api.Services.PermissionService;
using api.Services.RemarksService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel;
using System.Security.Claims;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RemarksController : ControllerBase
    {
        private readonly IRemarksService _remarksService;
        private readonly IPermissionService _permissionService;

        public RemarksController(IRemarksService remarksService, IPermissionService permissionService)
        {
            _remarksService = remarksService;
            _permissionService = permissionService;
        }

        [HttpGet("{license}")]
        [Authorize]
        public async Task<ActionResult<List<RemarkDTO>>> GetPlayerRemarks(string license, [FromQuery] int? limit)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_PLAYER_REMARKS"))
            {
                return Unauthorized();
            }

            var playerRemarks = await _remarksService.GetPlayerRemarks(license, limit);
            return Ok(playerRemarks);
        }

        // This does require a second db query to the game db, in order to collect the license for the citizen.
        [HttpGet("citizen/{citizenId}")]
        [Authorize]
        [Description("This is utlized to get all remarks for the citizens related license. It does require a database query to the game db to collect this information. Only use it if you have too.")]
        public async Task<ActionResult<PaginationResponseDTO<RemarkDTO>>> GetRemarksByCitizenId(string citizenId, [FromQuery] PaginationRequestDTO pagination, [FromQuery] string? where)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_PLAYER_REMARKS"))
            {
                return Unauthorized();
            }

            var playerRemarks = await _remarksService.GetRemarksByCitizenId(citizenId, pagination, where);
            return Ok(playerRemarks);
        }

        [HttpPost()]
        [Authorize]
        public async Task<ActionResult<RemarkDTO>> CreateRemark(CreateRemarkDTO data)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
            string? userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

            if (userId == null || !int.TryParse(userId, out _))
            {
                return Unauthorized();
            }

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_PLAYER_REMARKS"))
            {
                return Unauthorized();
            }

            var remark = await _remarksService.CreateRemark(data, int.Parse(userId));
            return Ok(remark);
        }
    }
}
