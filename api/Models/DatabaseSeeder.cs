using Microsoft.EntityFrameworkCore;
using System.Text.Json;

namespace api.Models
{
    public static class DatabaseSeeder
    {
        public static List<Permission> permissions = new List<Permission>
        {
            new Permission{ Key = "VIEW_ROLES", FriendlyName = "View Roles", Description = "Allow the user to view roles."},
            new Permission{ Key = "CREATE_ROLE", FriendlyName = "Create Roles", Description = "Allow the user to create new roles."},
            new Permission{ Key = "MODIFY_ROLES", FriendlyName = "Modify Roles", Description = "Allow the user to modify role permissions and order. Keep in mind they will be able to modify any permissions for roles below them."},
            new Permission{ Key = "DELETE_ROLES", FriendlyName = "Delete Roles", Description = "Allow the user to delete roles."},
            new Permission{ Key = "VIEW_USERS", FriendlyName = "View Users", Description = "View all registered users in the system."},
            new Permission{ Key = "ADD_USERS", FriendlyName = "Add Users", Description = "Allow the user to register new users to the system."},
            new Permission{ Key = "MODIFY_USERS", FriendlyName = "Modify Users", Description = "Allow the user to modify user details."},
            new Permission {Key = "VIEW_LOGS", FriendlyName = "View Logs", Description = "Allow the user to view and filter logs."},
            new Permission {Key = "VIEW_SYSTEM_SETTINGS", FriendlyName = "View System Settings", Description = "Allow the user to modify basic system settings."}
        };

        public static async Task Seed(DatabaseContext context)
        {
            await SeedPermissions(context);
            await SeedRoles(context);
            await SeedSuperAdminPermissions(context);
        }

        private static async Task SeedPermissions(DatabaseContext context)
        {
            using var transaction = await context.Database.BeginTransactionAsync();
            try
            {

                for (int i = 0; i < permissions.Count; i++)
                {
                    Permission? doesPermissionExist = context.Permissions.FirstOrDefault(p => p.Key.Equals(permissions[i].Key));

                    if (doesPermissionExist == null)
                    {
                        permissions[i].Id = i + 1;
                        context.Permissions.Add(permissions[i]);
                        await context.SaveChangesAsync();
                    }
                }

                await transaction.CommitAsync();

            } catch(Exception ex)
            {
                await transaction.RollbackAsync();
                throw;
            }
        }

        private static async Task SeedRoles(DatabaseContext context)
        {
            using var transaction = await context.Database.BeginTransactionAsync();
            try
            {

                Role superAdminRole = new Role
                {
                    Id = 1,
                    Key = "SUPER_ADMIN",
                    FriendlyName = "Super Admin",
                    CanBeDeleted = false,
                    CanBeEdited = false,
                    OrderLevel = 9999
                };

                Role baseUser = new Role
                {
                    Id = 2,
                    Key = "USER",
                    FriendlyName = "User",
                    CanBeDeleted = false,
                    OrderLevel = 1
                };

                if (!await DoesRoleExist(context, superAdminRole.Key))
                {
                    context.Roles.Add(superAdminRole);
                }

                if (!await DoesRoleExist(context, baseUser.Key))
                {
                    context.Roles.Add(baseUser);
                }

                await context.SaveChangesAsync();
                await transaction.CommitAsync();

            } catch(Exception ex)
            {
                await transaction.RollbackAsync();
                throw;
            }
        }

        private static async Task SeedSuperAdminPermissions(DatabaseContext context)
        {
            using var transaction = await context.Database.BeginTransactionAsync();
            try
            {
                List<Permission> _permissions = await context.Permissions.ToListAsync();

                foreach (Permission permission in _permissions)
                {
                    RolePermission? hasPermissionAlready = context.RolePermissions
                        .Where(rp => rp.RoleId == 1 && rp.PermissionId == permission.Id)
                        .SingleOrDefault();
                    
                    if (hasPermissionAlready == null)
                    {
                        RolePermission rolePermission = new RolePermission
                        {
                            PermissionId = permission.Id,
                            RoleId = 1
                        };

                        context.RolePermissions.Add(rolePermission);
                        await context.SaveChangesAsync();
                    }
                }

                await transaction.CommitAsync();

            } catch(Exception ex)
            {
                await transaction.RollbackAsync();
                throw;
            }
        }
        
        private static async Task<bool> DoesRoleExist(DatabaseContext context, string roleKey)
        {
            Role? role = await context.Roles.SingleOrDefaultAsync(r => r.Key == roleKey);
            return role != null;
        }
    }
}
