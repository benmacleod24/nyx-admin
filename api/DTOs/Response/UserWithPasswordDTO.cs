namespace api.DTOs.Response
{
    public class UserWithPasswordDTO
    {
        public int Id { get; set; }
        public required string UserName { get; set; }
        public string? Email { get; set; }
        public required string Password { get; set; }
    }
}
