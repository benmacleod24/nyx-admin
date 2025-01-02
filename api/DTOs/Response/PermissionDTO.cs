namespace api.DTOs.Response
{
    public class PermissionDTO
    {
        public int Id { get; set; }
        public required string Key { get; set; }
        public required string FriendlyName { get; set; }
        public string? Description { get; set; }
    }
}