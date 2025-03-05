namespace api.Models
{
    public class Log
    {
        public int Id { get; set; }
        public required string Message { get; set; }
        public string Level { get; set; } = "info";
        public ICollection<LogMetadataEntry> Metadata { get; set; } = new List<LogMetadataEntry>();
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
