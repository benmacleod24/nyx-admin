namespace api.DTOs
{
    public class SearchFilter
    {
        public required string Key { get; set; }
        public required string Value { get; set; }
        public required string Operator { get; set; }

    }
}
