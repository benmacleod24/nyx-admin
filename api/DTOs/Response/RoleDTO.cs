namespace api.DTOs.Response 
{
    public class RoleDTO
    {
        public int Id { get; set; }
        public int OrderLevel { get; set; }
        public string Key { get; set; }
        public string? FriendlyName { get; set; }
    }
}