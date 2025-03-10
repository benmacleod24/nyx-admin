namespace api.DTOs.Response
{
    public class RemarkDTO
    {
        public int Id { get; set; }
        public required string RemarkingUserName { get; set; }
        public required string Content { get; set; }
        public required DateTime Created {  get; set; }
    }
}
