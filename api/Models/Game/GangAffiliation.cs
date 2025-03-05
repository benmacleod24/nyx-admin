namespace api.Models.Game
{
    public class GangAffiliation
    {
        public string Label { get; set; } = null!;
        public string Name { get; set; } = null!;
        public bool IsBoss { get; set; }
        public Grade Grade { get; set; } = null!;
    }
}
