using api.DTOs.Request;
using api.DTOs.Response;

namespace api.Services.LogService
{
    public interface ILogService
    {
        public Task<LogDTO> CreateLog(CreateLogDTO log);
        public Task<PaginationResponseDTO<LogDTO>> GetAllLogs(PaginationRequestDTO paginationRequest);
        public Task<PaginationResponseDTO<LogDTO>> SearchLogs(SearchLogsDTO searchRequest);
        public Task<LogDTO> GetLogById(int id);
        public Task<List<string>> GetMetadataKeys();
    }
}
