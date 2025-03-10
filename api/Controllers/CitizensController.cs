using api.DTOs.Request;
using api.DTOs.Response;
using api.Models.Game;
using api.Services.CitizenService;
using api.Services.PermissionService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Security.Claims;
using System.Text.Json;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CitizensController : ControllerBase
    {
        private readonly ICitizenService _citizenService;
        private readonly IPermissionService _permissionService;

        public CitizensController(ICitizenService citizenService, IPermissionService permissionService)
        {
            _citizenService = citizenService;
            _permissionService = permissionService;
        }

        [HttpPost("search")]
        [Authorize]
        public async Task<ActionResult<List<CitizenDTO>>> SearchCitizens([FromBody] SearchPlayersDTO request)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_PLAYERS"))
            {
                return Unauthorized();
            }

            return Ok(await _citizenService.SearchCitizens(request));
        }

        [HttpGet("{citizenId}")]
        [Authorize]
        public async Task<ActionResult<CitizenDTO>> GetCitizenById(string citizenId)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_PLAYERS"))
            {
                return Unauthorized();
            }

            CitizenDTO? player = await _citizenService.GetCitizenById(citizenId);
            return Ok(player);
        }

        [HttpGet("{citizenId}/related-citizens")]
        [Authorize]
        public async Task<ActionResult<List<CitizenDTO>>> GetRelatedCitizens(string citizenId)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_RELATED_CITIZENS"))
            {
                return Unauthorized();
            }

            List<CitizenDTO> relatedCitizens = await _citizenService.GetRelatedCitizens(citizenId);
            return Ok(relatedCitizens);
        }
    }
}
