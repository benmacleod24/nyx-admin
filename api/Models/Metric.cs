namespace api.Models
{
    public class Metric
    {
        public int Id { get; set; }
        public required string Key { get; set; }
        public required double Value { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    }
}
