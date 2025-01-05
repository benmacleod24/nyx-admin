using api.DTOs.Response;

namespace api.Services.PermissionService
{
    public interface IPermissionService
    {
        public Task<bool> DoesRoleHavePermission(string roleKey, string permissionKey);
        public Task<List<PermissionDTO>> GetAllPermissions();
    }
}