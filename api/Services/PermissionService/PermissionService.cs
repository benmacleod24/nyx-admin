using api.DTOs.Response;
using api.Models;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;

namespace api.Services.PermissionService
{
    public class PermissionService : IPermissionService
    {
        private readonly DatabaseContext _context;
        private readonly IMapper _mapper;

        public PermissionService(DatabaseContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<bool> DoesRoleHavePermission(string roleKey, string permissionKey)
        {
            RolePermission? rolePermission = await _context.RolePermissions
                .Where(v => v.Permission.Key.Equals(permissionKey) && v.Role.Key.Equals(roleKey))
                .FirstOrDefaultAsync();

            return rolePermission == null ? false : true;
        }

        public async Task<List<PermissionDTO>> GetAllPermissions()
        {
            List<PermissionDTO> permissions = await _context.Permissions
                .ProjectTo<PermissionDTO>(_mapper.ConfigurationProvider)
                .ToListAsync();

            return permissions;
        }
    }
}