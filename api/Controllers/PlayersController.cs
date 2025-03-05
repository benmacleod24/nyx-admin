using api.DTOs.Request;
using api.DTOs.Response;
using api.Models.Game;
using api.Services.CharacterService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System.Text.Json;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlayersController : ControllerBase
    {
        private readonly IPlayerService _playerService;

        public PlayersController(IPlayerService playerService)
        {
            _playerService = playerService;
        }

        [HttpPost("search")]
        [Authorize]
        public async Task<ActionResult<List<PlayerDTO>>> SearchPlayers([FromBody] SearchPlayersDTO request)
        {
            return Ok(await _playerService.SearchPlayers(request));
        }
    }
}
