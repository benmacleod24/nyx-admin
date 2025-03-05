namespace api.Models.Game
{
    public class PlayerJob
    {
        public bool OnDuty { get; set; }
        public string Name { get; set; }
        public Grade Grade { get; set; }
        public string Label { get; set; }
        public bool IsBoss { get; set; }
        public string Type { get; set; }
        public int Payment { get; set; }
    }
}
