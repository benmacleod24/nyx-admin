namespace api.DTOs.Response
{
    public class LogDTO
    {
        public required int Id { get; set; }
        public required string Level { get; set; }
        public required string Message { get; set; }
        public Dictionary<string, object>? Metadata { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
