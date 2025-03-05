using System.Security.Claims;
using System.Text.Json;
using api.DTOs.Response;
using api.Services.RoleService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IRoleService _roleService;

        public UserController(IRoleService roleService)
        {
            _roleService = roleService;
        }

        [HttpGet("permissions")]
        [Authorize]
        public async Task<ActionResult> GetUserPermissions()
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(v => v.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            List<PermissionDTO> permissions = await _roleService.GetRolePermissionsByKey(roleKey);

            Console.WriteLine(JsonSerializer.Serialize(permissions));

            return Ok(permissions);
        }
    }
}