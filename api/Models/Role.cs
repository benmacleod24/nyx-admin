namespace api.Models 
{
    public class Role 
    {
        public int Id { get; set; }
        public int OrderLevel { get; set; } // The level to determine what role is above one another.
        public required string Key { get; set; } // Key name like DEV_START, ADMIN, SUPER_ADMIN
        public string? FriendlyName { get; set; } // Friendly name like Developer, Support
        public bool CanBeEdited { get; set; } = true; // Enable/Disabled editing of the role.
        public ICollection<User> Users { get; } = new List<User>();
        public ICollection<RolePermission> Permissions { get; set; } = new List<RolePermission>();
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public bool CanBeDeleted { get; set; } = true;
    }
}