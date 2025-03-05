namespace api.DTOs.Request
{
    public class CreateUITableColumn
    {
        public required string TableKey { get; set; }
        public required string ValuePath { get; set; }
        public string Friendlyname { get; set; } = string.Empty;
    }
}
