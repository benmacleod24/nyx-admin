using System.Security.Claims;
using System.Text.Json;
using api.DTOs.Response;
using api.Services.PermissionService;
using api.Services.RoleService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PermissionsController : ControllerBase
    {
        private readonly IPermissionService _permissionService;

        public PermissionsController(IPermissionService permissionService)
        {
            _permissionService = permissionService;
        }

        [HttpGet]
        [Authorize]
        public async Task<ActionResult> GetUserPermissions()
        {
            List<PermissionDTO> permissions = await _permissionService.GetAllPermissions();
            Console.WriteLine(JsonSerializer.Serialize(permissions));
            return Ok(permissions);
        }
    }
}