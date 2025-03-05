namespace api.Models.Game
{
    public class CharInfo
    {
        public string Phone { get; set; } = null!;
        public string Nationality { get; set; } = null!;
        public string Lastname { get; set; } = null!;
        public int Gender { get; set; }
        public string Account { get; set; } = null!;
        public int Cid { get; set; }
        public DateTime Birthdate { get; set; }
        public string Firstname { get; set; } = null!;
    }
}
