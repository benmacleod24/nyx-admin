namespace api.DTOs.Response
{
    public class UserDTO
    {
        public int Id { get; set; }
        public required string UserName { get; set; }
        public string? Email { get; set; }
    }
}
