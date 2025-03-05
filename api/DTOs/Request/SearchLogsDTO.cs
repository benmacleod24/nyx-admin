namespace api.DTOs.Request
{
    public class SearchLogsDTO : PaginationRequestDTO
    {
        public List<SearchFilter> Filters { get; set; } = new List<SearchFilter>();
        public DateTime StartTime { get; set; } = DateTime.Now;
        public DateTime EndTime { get; set; } = DateTime.Now.AddDays(-1);
    }
}
