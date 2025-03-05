using System;
using System.Collections.Generic;

namespace api.Models.Game;

public partial class Ban
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public string? License { get; set; }

    public string? Discord { get; set; }

    public string? Ip { get; set; }

    public string? Reason { get; set; }

    public int? Expire { get; set; }

    public string Bannedby { get; set; } = null!;
}
