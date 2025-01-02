using System.Security.Claims;
using api.DTOs.Response;
using api.Services.RoleService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PermissionsController : ControllerBase
    {
        private readonly IRoleService _roleService;

        public PermissionsController(IRoleService roleService)
        {
            _roleService = roleService;
        }

        [HttpGet]
        [Authorize]
        public async Task<ActionResult> GetUserPermissions()
        {
            string? userRole = HttpContext.User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Role)?.Value;

            if (userRole == null || String.IsNullOrEmpty(userRole))
            {
                throw new Exception("User role not assigned.");
            }

            List<PermissionDTO> permissions = await _roleService.GetRolePermissionsByKey(userRole);

            return Ok(permissions);
        }
    }
}