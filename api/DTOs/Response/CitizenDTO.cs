using api.Models.Game;

namespace api.DTOs.Response
{
    public class CitizenDTO
    {
        public string CitizenId { get; set; } = null!;
        public string License {  get; set; } = null!;
        public string Name { get; set; } = null!;
        public CharInfo CharInfo { get; set; } = null!;
        public PlayerMoney Money { get; set; } = null!;
        public string PhoneNumber {  get; set; } = null!;
        public GangAffiliation Gang {  get; set; } = null!;
        public PlayerJob Job { get; set; } = null!;
    }
}
