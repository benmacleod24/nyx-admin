namespace api.Models
{
    public class PlayerRemark
    {
        public int Id { get; set; }
        public required string License { get; set; }
        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public required string Content { get; set; }
        public DateTime Created { get; set; } = DateTime.Now;
    }
}
