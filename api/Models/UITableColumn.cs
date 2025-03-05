namespace api.Models
{
    public class UITableColumn
    {
        public int Id { get; set; }
        public required string TableKey { get; set; }
        public string FriendlyName { get; set; } = null!;
        public required string ValuePath { get; set; }
    }
}
