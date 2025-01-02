namespace api.Models
{
    public class User
    {
        public int Id { get; set; }
        public required string Username { get; set; }
        public string? Password { get; set; }
        public string? Email { get; set; } // Used for resettings password if need be.
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime LastUpdatedAt { get; set; } = DateTime.UtcNow;
        public ICollection<RefreshToken> RefreshTokens { get; set; } = new List<RefreshToken>();
    }
}
