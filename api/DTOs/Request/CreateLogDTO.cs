namespace api.DTOs.Request
{
    public class CreateLogDTO
    {
        public string? Level { get; set; } = "info";
        public required string Message { get; set; }
        public Dictionary<string, object>? Metadata { get; set; } = new Dictionary<string, object>();

    }
}
