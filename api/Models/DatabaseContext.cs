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
