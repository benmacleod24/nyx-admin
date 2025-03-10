using api.DTOs.Request;
using api.DTOs.Response;

namespace api.Services.RemarksService
{
    public interface IRemarksService
    {
        public Task<List<RemarkDTO>> GetPlayerRemarks(string license, int? limit);
        public Task<PaginationResponseDTO<RemarkDTO>> GetRemarksByCitizenId(string citizenId, PaginationRequestDTO pagination, string? where);
        public Task<RemarkDTO> CreateRemark(CreateRemarkDTO data, int userId);
    }
}
