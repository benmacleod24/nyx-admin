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

        [HttpGet("{roleKey}")]
        [Authorize]
        public async Task<ActionResult> GetRoleByKey(string roleKey)
        {
            string? userRole = HttpContext.User.Claims.FirstOrDefault(v => v.Type == ClaimTypes.Role)?.Value;

            if (userRole == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(userRole, "VIEW_ROLES"))
            {
                return Unauthorized();
            }

            RoleDTO? role = await _roleService.GetRoleByKey(roleKey);
            return Ok(role);
        }

        [HttpPut("{roleKey}")]
        [Authorize]
        public async Task<ActionResult> UpdateRole(string roleKey, [FromBody] UpdateRoleDTO updatedRole)
        {
            string? userRole = HttpContext.User.Claims.FirstOrDefault(v => v.Type == ClaimTypes.Role)?.Value;

            if (userRole == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(userRole, "MODIFY_ROLES"))
            {
                return Unauthorized();
            }

            await _roleService.UpdateRole(roleKey, updatedRole);
            return Ok();
        }

        [HttpDelete("{roleKey}")]
        [Authorize]
        public async Task<ActionResult> DeleteRole(string roleKey)
        {
            string? userRole = HttpContext.User.Claims.FirstOrDefault(v => v.Type == ClaimTypes.Role)?.Value;

            if (userRole == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(userRole, "DELETE_ROLES"))
            {
                return Unauthorized();
            }

            await _roleService.DeleteRole(roleKey);
            return Ok();
        }

        [HttpGet("{roleKey}/permissions")]
        [Authorize]
        public async Task<ActionResult> GetRolePermissions(string roleKey)
        {
            string? userRole = HttpContext.User.Claims.FirstOrDefault(v => v.Type == ClaimTypes.Role)?.Value;

            if (userRole == null)
            {
                return Unauthorized();
            }

            if (!await _permissionService.DoesRoleHavePermission(userRole, "VIEW_ROLES"))
            {
                return Unauthorized();
            }

            List<PermissionDTO> rolePermissions = await _roleService.GetRolePermissionsByKey(roleKey);
            List<string> permissionKeyList = new List<string>();

            foreach (PermissionDTO rolePermission in rolePermissions)
            {
                permissionKeyList.Add(rolePermission.Key);
            }

            return Ok(permissionKeyList);
        }

        [HttpPost("update-order")]
        [Authorize]
        public async Task<ActionResult> UpdateRoleOrder(List<UpdateRoleOrderDTO> roleUpates)
        {
            string? userRole = HttpContext.User.Claims.FirstOrDefault(r => r.Type == ClaimTypes.Role)?.Value;

            if (userRole == null)
            {
                return Unauthorized();
            }

            bool hasPermission = await _permissionService.DoesRoleHavePermission(userRole, "MODIFY_ROLES");
            if (!hasPermission)
            {
                return Unauthorized();
            } 

            List<RoleDTO> updatedRoleList = await _roleService.UpdateRoleOrder(roleUpates);
            return Ok(updatedRoleList);
        }
    }
}