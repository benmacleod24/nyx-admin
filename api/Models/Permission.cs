namespace api.Models
{
    public class Permission
    {
        public int Id { get; set;}
        public required string Key { get; set; }
        public required string FriendlyName { get; set; }
        public string? Description { get; set; }
        public ICollection<RolePermission> Roles { get; set; } = new List<RolePermission>();
    }
}