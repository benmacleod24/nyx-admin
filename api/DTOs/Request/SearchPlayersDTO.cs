namespace api.DTOs.Request
{
    public class SearchPlayersDTO : PaginationRequestDTO
    {
        public List<SearchFilter> Filters { get; set; } = new List<SearchFilter>();
        public string? SortBy { get; set; }
        public string? SortOrder { get; set; }
    }
}
