using api.Models;
using Microsoft.EntityFrameworkCore;

namespace api.Services.PermissionService
{
    public class PermissionService : IPermissionService
    {
        private readonly DatabaseContext _context;

        public PermissionService(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<bool> DoesRoleHavePermission(string roleKey, string permissionKey)
        {
            RolePermission? rolePermission = await _context.RolePermissions
                .Where(v => v.Permission.Key.Equals(permissionKey) && v.Role.Key.Equals(roleKey))
                .FirstOrDefaultAsync();

            return rolePermission == null ? false : true;
        }
    }
}