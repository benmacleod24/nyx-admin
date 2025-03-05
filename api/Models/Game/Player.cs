using System;
using System.Collections.Generic;

namespace api.Models.Game;

public partial class Player
{
    public int Id { get; set; }

    public string Citizenid { get; set; } = null!;

    public int? Cid { get; set; }

    public string License { get; set; } = null!;

    public string Name { get; set; } = null!;

    public PlayerMoney Money { get; set; } = null!;

    public CharInfo Charinfo { get; set; } = null!;

    public PlayerJob Job { get; set; } = null!;

    public GangAffiliation? Gang { get; set; }

    public string Position { get; set; } = null!;

    public string Metadata { get; set; } = null!;

    public string? Inventory { get; set; }

    public DateTime LastUpdated { get; set; }

    public string? PhoneNumber { get; set; }

    public int CrmSlot { get; set; }

    public int CrmAvatarId { get; set; }

    public int CrmFavorite { get; set; }

    public string CrmIsPremium { get; set; } = null!;

    public string CrmTattoos { get; set; } = null!;

    public string Cryptocurrency { get; set; } = null!;

    public string? CryptoWalletId { get; set; }

    public string? Inside { get; set; }

    public int CrmCk { get; set; }
}
