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
                    new Permission{ Id = 1, Key = "VIEW_SYSTEM_SETTINGS", FriendlyName = "View System Settings"}
                );

            // Seed default roles into database
            modelBuilder.Entity<Role>().HasData(
                new Role{ Id = 1, Key = "SUPER_ADMIN", FriendlyName = "Super Admin", CanBeEdited = false },
                new Role{ Id = 2, Key = "USER", FriendlyName = "User" }
            );

            modelBuilder.Entity<RolePermission>()
                .HasData(
                    new RolePermission {Id = 1, PermissionId = 1, RoleId = 1}
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
