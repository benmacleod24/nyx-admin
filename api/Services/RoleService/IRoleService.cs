using api.DTOs.Request;
using api.DTOs.Response;
using api.Models;

namespace api.Services.RoleService
{
    public interface IRoleService
    {
        public Task<List<RoleDTO>> GetAllRoles();
        public Task<RoleDTO> CreateRole(CreateRoleDTO roleData);
        public Task<RoleDTO?> GetRoleByKey(string roleKey);
        public Task<RoleDTO?> GetRoleById(int roleId);
        public Task<List<PermissionDTO>> GetRolePermissionsByKey(string roleKey);
        public Task<List<PermissionDTO>> GetRolePermissionsById(int roleId);
    }
}