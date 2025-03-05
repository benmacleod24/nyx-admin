using api.DTOs.Request;
using api.DTOs.Response;
using api.Models.Game;
using api.Services.CharacterService;
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
    public class PlayersController : ControllerBase
    {
        private readonly IPlayerService _playerService;
        private readonly IPermissionService _permissionService;

        public PlayersController(IPlayerService playerService, IPermissionService permissionService)
        {
            _playerService = playerService;
            _permissionService = permissionService;
        }

        [HttpPost("search")]
        [Authorize]
        public async Task<ActionResult<List<PlayerDTO>>> SearchPlayers([FromBody] SearchPlayersDTO request)
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

            return Ok(await _playerService.SearchPlayers(request));
        }

        [HttpGet("{citizenId}")]
        [Authorize]
        public async Task<ActionResult<PlayerDTO>> GetPlayerByCitizenId(string citizenId)
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

            PlayerDTO? player = await _playerService.GetPlayerByCitizenId(citizenId);
            return Ok(player);
        }
    }
}
