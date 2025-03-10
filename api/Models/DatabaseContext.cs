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
            // Username are unique.
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Username)
                .IsUnique();

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

            // Set default value for Role to User.
            modelBuilder.Entity<User>()
                .Property(u => u.IsDisabled)
                .HasDefaultValue(false);

            modelBuilder.Entity<LogMetadataEntry>()
                .HasIndex(m => new { m.LogId, m.Key })
                .IsUnique();

            modelBuilder.Entity<Log>()
                .HasMany(l => l.Metadata)
                .WithOne(m => m.Log)
                .HasForeignKey(m => m.LogId);

            modelBuilder.Entity<LogMetadataEntry>()
                .Property(m => m.Key)
                .IsRequired();

            modelBuilder.Entity<LogMetadataEntry>()
                .Property(m => m.Value)
                .IsRequired();

            base.OnModelCreating(modelBuilder);
        }

        public DbSet<User> Users { get; set; }
        public DbSet<RefreshToken> RefreshTokens { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Permission> Permissions { get; set; }
        public DbSet<RolePermission> RolePermissions { get; set; }
        public DbSet<Log> Logs  { get; set; }
        public DbSet<LogMetadataEntry> LogMetadataEntries { get; set; }
        public DbSet<UITableColumn> UITableColumns { get; set; }
        public DbSet<PlayerRemark> PlayerRemarks { get; set; }
        public DbSet<Metric> Metrics {  get; set; }
    }
}
