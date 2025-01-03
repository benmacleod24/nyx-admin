using api.DTOs.Request;
using api.DTOs.Response;
using api.Extentions;
using api.Models;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;

namespace api.Services.RoleService
{
    public class RoleService : IRoleService
    {
        private readonly DatabaseContext _context;
        private readonly IMapper _mapper;

        public RoleService(DatabaseContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<RoleDTO>> GetAllRoles()
        {
            List<RoleDTO> roles = await _context.Roles
                .ProjectTo<RoleDTO>(_mapper.ConfigurationProvider)
                .ToListAsync();

            return roles;
        }

        public async Task<RoleDTO> CreateRole(CreateRoleDTO roleData)
        {
            Role role = new Role
            {
                Key = roleData.Key,
                FriendlyName = roleData.FriendlyName,
            };

            // Saves role to the database.
            _context.Roles.Add(role);
            await _context.SaveChangesAsync();

            return _mapper.Map<RoleDTO>(role);
        }

        public async Task<RoleDTO?> GetRoleByKey(string roleKey)
        {
            Role? role = await _context.Roles
                .Where(r => r.Key.Equals(roleKey))
                .FirstOrDefaultAsync();

            return _mapper.Map<RoleDTO>(role);
        }

        public async Task<RoleDTO> GetRoleById(int roleId)
        {
            Role? role = await _context.Roles
                .Where(r => r.Id.Equals(roleId))
                .FirstOrDefaultAsync();
            
            return _mapper.Map<RoleDTO>(role);
        }

        public async Task<List<PermissionDTO>> GetRolePermissionsByKey(string roleKey)
        {
            List<PermissionDTO> permissions = await _context.RolePermissions
                .Where(rp => rp.Role.Key.Equals(roleKey))
                .Select(rp => rp.Permission)
                .ProjectTo<PermissionDTO>(_mapper.ConfigurationProvider)
                .ToListAsync();

            return permissions;
        }

        public async Task<List<PermissionDTO>> GetRolePermissionsById(int roleId)
        {
            List<PermissionDTO> permissions = await _context.RolePermissions
                .Where(rp => rp.RoleId.Equals(roleId))
                .Select(rp => rp.Permission)
                .ProjectTo<PermissionDTO>(_mapper.ConfigurationProvider)
                .ToListAsync();

            return permissions;
        }
    }
}