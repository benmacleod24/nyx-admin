namespace api.DTOs.Response
{
    public class PaginationResponseDTO<T>
    {
        public IEnumerable<T> Items { get; set; }
        public int TotalPages { get; set; }
    }
}
