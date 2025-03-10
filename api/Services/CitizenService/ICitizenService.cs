using api.DTOs.Request;
using api.DTOs.Response;

namespace api.Services.CitizenService
{
    public interface ICitizenService
    {
        public Task<PaginationResponseDTO<CitizenDTO>> SearchCitizens(SearchPlayersDTO request);
        public Task<CitizenDTO?> GetCitizenById(string citizenId);
        public Task<List<CitizenDTO>> GetRelatedCitizens(string citizenId);
    }
}
