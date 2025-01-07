using api.Common.Constants;
using api.DTOs.Request;
using api.DTOs.Response;
using api.Extentions;
using api.Models;
using api.Services.PermissionService;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;

namespace api.Services.RoleService
{
    public class RoleService : IRoleService
    {
        private readonly DatabaseContext _context;
        private readonly IMapper _mapper;
        private readonly IPermissionService _permissionService;

        public RoleService(DatabaseContext context, IMapper mapper, IPermissionService permissionService)
        {
            _context = context;
            _mapper = mapper;
            _permissionService = permissionService;
        }

        public async Task<List<RoleDTO>> GetAllRoles()
        {
            List<RoleDTO> roles = await _context.Roles
                .Where(r => r.CanBeEdited)
                .OrderByDescending(r => r.OrderLevel)
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
                OrderLevel = 0
            };

            // Saves role to the database.
            _context.Roles.Add(role);
            await _context.SaveChangesAsync();

            // Now that we created the new role we must increment each role level by one.
            await UpdateRolesOrderLevel();

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

        public async Task<List<RoleDTO>> UpdateRoleOrder(List<UpdateRoleOrderDTO> updatedList)
        {
            var roleIds = updatedList.Select(r => r.RoleId);
            List<Role> roles = await _context.Roles
                .Where(r => r.CanBeEdited && roleIds.Contains(r.Id))
                .ToListAsync();

            foreach (Role data in roles)
            {
                var update = updatedList.First(r => r.RoleId == data.Id);
                data.OrderLevel = update.OrderLevel;
            }

            await _context.SaveChangesAsync();

            return await GetAllRoles();
        }

        public async Task<RolePermission> AddPermissionToRole(string roleKey, int permissionId)
        {
            RoleDTO? role = await GetRoleByKey(roleKey);

            if (role == null)
            {
                throw new Exception("Role not found");
            }

            RolePermission rolePermission = new RolePermission
            {
                PermissionId = permissionId,
                RoleId = role.Id
            };

            _context.RolePermissions.Add(rolePermission);
            await _context.SaveChangesAsync();

            return rolePermission;
        }

        public async Task RemovePermissionFromRole(string roleKey, int permissionId)
        {
            RolePermission? role = await _context.RolePermissions
                .Where(r => r.Role.Key.Equals(roleKey))
                .FirstOrDefaultAsync();

            if (role == null)
            {
                throw new Exception("Role not found");
            }

            _context.RolePermissions.Remove(role);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateRole(string roleKey, UpdateRoleDTO updatedRole)
        {
            List<RolePermission> rolePermissions = await _context.RolePermissions
                .Where(r => r.Role.Key.Equals(roleKey))
                .Include(r => r.Permission)
                .ToListAsync();

            foreach (RolePermission rolePermission in rolePermissions)
            {
                if (!updatedRole.permissions.Contains(rolePermission.Permission.Key))
                {
                    _context.RolePermissions.Remove(rolePermission);
                    continue;
                }
            }

            List<string> rolePermisionsId = rolePermissions.Select(r => r.Permission.Key).ToList();
            RoleDTO? role = await GetRoleByKey(roleKey);

            if (role == null) 
            {
                throw new Exception("Role not found");
            }

            foreach (string permissionKey in updatedRole.permissions)
            {
                if (!rolePermisionsId.Contains(permissionKey))
                {
                    PermissionDTO? permission = await _permissionService.GetPermissionByKey(permissionKey);

                    if (permission == null) continue;

                    RolePermission newRolePermission = new RolePermission
                    {
                        RoleId = role.Id,
                        PermissionId = permission.Id
                    };

                    _context.RolePermissions.Add(newRolePermission);
                }
            }

            await _context.SaveChangesAsync();
        }

        public async Task DeleteRole(string roleKey)
        {
            Role? role = await _context.Roles
                .Where(c => c.Key.Equals(roleKey))
                .FirstOrDefaultAsync();

            if (role == null)
            {
                throw new Exception("Role not found");
            }

            if (!role.CanBeDeleted)
            {
                throw new Exception("This role can not be deleted.");
            }

            List<User> usersWithRole = await _context.Users
                .Where(u => u.RoleId == role.Id)
                .ToListAsync();

            foreach (User user in usersWithRole)
            {
                user.RoleId = DefaultValues.DefaultUserId;
            }

            _context.Roles.Remove(role);
            await _context.SaveChangesAsync();
        }

        private async Task UpdateRolesOrderLevel()
        {
            // Only update roles that are editable.
            List<Role> roles = await _context.Roles
                .Where(r => r.CanBeEdited)
                .OrderByDescending(r => r.OrderLevel)
                .ToListAsync();

            foreach (Role role in roles)
            {
                role.OrderLevel++;
            }

            await _context.SaveChangesAsync();
        }
    }
}