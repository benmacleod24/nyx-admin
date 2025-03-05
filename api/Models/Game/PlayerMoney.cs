using Microsoft.EntityFrameworkCore;

namespace api.Models.Game
{
    [Owned]
    public class PlayerMoney
    {
        public int Cash { get; set; }
        public int Bank { get; set; }
        public int Crypto {  get; set; }
    }
}
