using System.Security.Claims;
using api.DTOs.Response;
using api.Services.PermissionService;
using api.Services.UserService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IPermissionService _permissionService;

        public UsersController(IUserService userService, IPermissionService permissionService)
        {
            _userService = userService;
            _permissionService = permissionService;
        }

        [HttpGet()]
        [Authorize]
        public async Task<ActionResult> GetAllUsers()
        {
            string? userRoleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (userRoleKey == null) return Unauthorized();
            if (!await _permissionService.DoesRoleHavePermission(userRoleKey, "VIEW_USERS")) return Unauthorized();

            List<UserDTO> users = await _userService.GetAllUsers();
            return Ok(users);
        }
    }
}