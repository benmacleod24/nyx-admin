using Microsoft.EntityFrameworkCore;

namespace api.Models.Game
{
    [Owned]
    public class PlayerMoney
    {
        public double Cash { get; set; }
        public double Bank { get; set; }
        public double Crypto {  get; set; }
    }
}
