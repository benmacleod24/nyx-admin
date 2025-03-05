using api.Models;

namespace api.DTOs.Response
{
    public class UserDTO
    {
        public int Id { get; set; }
        public required string UserName { get; set; }
        public string? Email { get; set; }
        public RoleDTO? Role { get; set; }
        public bool IsDisabled { get; set; }
    }
}
