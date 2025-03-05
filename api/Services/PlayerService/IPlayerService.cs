using api.DTOs.Request;
using api.DTOs.Response;

namespace api.Services.CharacterService
{
    public interface IPlayerService
    {
        public Task<PaginationResponseDTO<PlayerDTO>> SearchPlayers(SearchPlayersDTO request);
    }
}
