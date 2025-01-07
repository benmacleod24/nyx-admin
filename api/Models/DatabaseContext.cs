using Microsoft.EntityFrameworkCore;

namespace api.Models
{
    public class DatabaseContext : DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Make the Role Key Unique.
            modelBuilder.Entity<Role>()
                .HasIndex(r => r.Key)
                .IsUnique();

            // Make permission key unique.
            modelBuilder.Entity<Permission>()
                .HasIndex(r => r.Key)
                .IsUnique();

            modelBuilder.Entity<Permission>()
                .HasData(
                    new Permission{ Id = 1, Key = "VIEW_ROLES", FriendlyName = "View Roles", Description = "Allow the user to view roles."},
                    new Permission{ Id = 2, Key = "CREATE_ROLE", FriendlyName = "Create Roles", Description = "Allow the user to create new roles."},
                    new Permission{ Id = 3, Key = "MODIFY_ROLES", FriendlyName = "Modify Roles", Description = "Allow the user to modify role permissions and order. Keep in mind they will be able to modify any permissions for roles below them."},
                    new Permission{ Id = 4, Key = "DELETE_ROLES", FriendlyName = "Delete Roles", Description = "Allow the user to delete roles."},
                    new Permission{ Id = 5, Key = "VIEW_USERS", FriendlyName = "View Users", Description = "View all registered users in the system."}
                );

            // Seed default roles into database
            modelBuilder.Entity<Role>().HasData(
                new Role{ Id = 1, Key = "SUPER_ADMIN", FriendlyName = "Super Admin", CanBeEdited = false, CanBeDeleted = false, OrderLevel = 9999 },
                new Role{ Id = 2, Key = "USER", FriendlyName = "User", CanBeDeleted = false }
            );

            modelBuilder.Entity<RolePermission>()
                .HasData(
                    new RolePermission {Id = 1, PermissionId = 1, RoleId = 1},
                    new RolePermission {Id = 2, PermissionId = 2, RoleId = 1},
                    new RolePermission {Id = 3, PermissionId = 3, RoleId = 1},
                    new RolePermission {Id = 4, PermissionId = 4, RoleId = 1},
                    new RolePermission {Id = 5, PermissionId = 5, RoleId = 1}
                );

            // Set default value for Role to User.
            modelBuilder.Entity<User>()
                .Property(u => u.RoleId)
                .HasDefaultValue(2);

            base.OnModelCreating(modelBuilder);
        }

        public DbSet<User> Users { get; set; }
        public DbSet<RefreshToken> RefreshTokens { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Permission> Permissions { get; set; }
        public DbSet<RolePermission> RolePermissions { get; set; }
    }
}
