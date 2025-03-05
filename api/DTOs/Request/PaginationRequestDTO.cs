namespace api.DTOs.Request
{
    public class PaginationRequestDTO
    {
        public int Page { get; set; } = 1;
        public int Size { get; set; } = 10;
    }
}
