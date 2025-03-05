namespace api.Models
{
    public class LogMetadataEntry
    {
        public int Id { get; set; }
        public int LogId { get; set; }
        public Log Log { get; set; } = null!;
        public required string Key { get; set; }
        public required string Value { get; set; }
    }
}
