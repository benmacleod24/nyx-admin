namespace api.DTOs.Request
{
    public class UpdateUserDTO
    {
        public int? UserId { get; set; }
        public string? UserName { get; set; }
        public string? Password { get; set; }
        public required string RoleKey { get; set; }
        public required bool IsDisabled { get; set; }
    }
}
