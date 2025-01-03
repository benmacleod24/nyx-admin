using System.Security.Claims;
using api.DTOs.Request;
using api.DTOs.Response;
using api.Models;
using api.Services.PermissionService;
using api.Services.RoleService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RolesController : ControllerBase
    {
        private readonly IRoleService _roleService;
        private readonly IPermissionService _permissionService;

        public RolesController(IRoleService roleService, IPermissionService permissionService)
        {
            _roleService = roleService;
            _permissionService = permissionService;
        }

        [HttpGet]
        [Authorize]
        public async Task<ActionResult> GetAllRoles()
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null) 
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "VIEW_ROLES"))
            {
                return Unauthorized();
            }

            List<RoleDTO> roles = await _roleService.GetAllRoles();
            return Ok(roles);
        }

        [HttpPost]
        [Authorize]
        public async Task<ActionResult> CreateRole(CreateRoleDTO roleData)
        {
            string? roleKey = HttpContext.User.Claims.FirstOrDefault(v => v.Type == ClaimTypes.Role)?.Value;

            if (roleKey == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(roleKey, "CREATE_ROLE"))
            {
                return Unauthorized();
            }

            RoleDTO role = await _roleService.CreateRole(roleData);
            return Ok(role);
        }

        [HttpGet("{roleKey}/permissions")]
        [Authorize]
        public async Task<ActionResult> GetRolePermissions(string roleKey)
        {
            List<PermissionDTO> rolePermissions = await _roleService.GetRolePermissionsByKey(roleKey);
            List<string> permissionKeyList = new List<string>();

            foreach (PermissionDTO rolePermission in rolePermissions)
            {
                permissionKeyList.Add(rolePermission.Key);
            }

            return Ok(permissionKeyList);
        }
    }
}