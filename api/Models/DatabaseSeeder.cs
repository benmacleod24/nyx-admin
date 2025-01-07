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
            new Permission{ Key = "VIEW_USERS", FriendlyName = "View Users", Description = "View all registered users in the system."}
        };

        public static async Task Seed(DatabaseContext context)
        {
            using var transaction = await context.Database.BeginTransactionAsync();

            try
            {
                // Add each permission to the database.
                for (int i = 0; i < permissions.Count; i++)
                {
                    Permission? doesPermissionExist = context.Permissions.FirstOrDefault(p => p.Key.Equals(permissions[i].Key));
                    if (doesPermissionExist == null)
                    {
                        permissions[i].Id = i + 1;
                        context.Permissions.Add(permissions[i]);
                    }
                    else
                    {
                        context.Permissions
                            .Where(p => p.Key.Equals(permissions[i].Key))
                            .ExecuteUpdate(p =>
                                p.SetProperty(c => c.FriendlyName, permissions[i].FriendlyName)
                                .SetProperty(c => c.Description, permissions[i].Description)
                                
                            );
                        permissions[i].Id = doesPermissionExist.Id;
                    }
                }

                // Default Roles.
                Role superAdminRole = new Role { Id = 1, Key = "SUPER_ADMIN", FriendlyName = "Super Admin", CanBeEdited = false, CanBeDeleted = false, OrderLevel = 9999 };
                Role userRole = new Role { Id = 2, Key = "USER", FriendlyName = "User", CanBeDeleted = false };

                if (!await DoesRoleExist(context, superAdminRole.Key))
                {
                    context.Roles.Add(superAdminRole);
                }

                if (!await DoesRoleExist(context, userRole.Key))
                {
                    context.Roles.Add(userRole);
                }

                // Assign all permissions to super admin.
                for (int i = 0; i < permissions.Count; i++)
                {
                    RolePermission? doesRolePermissionExist = context.RolePermissions.Where(rp => rp.RoleId == superAdminRole.Id && rp.PermissionId == permissions[i].Id).FirstOrDefault();
                    if (doesRolePermissionExist != null) return;
                    RolePermission rolePermissions = new RolePermission { Id = i + 1, PermissionId = permissions[i].Id, RoleId = superAdminRole.Id };
                    context.RolePermissions.Add(rolePermissions);
                }

                await context.SaveChangesAsync();
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
