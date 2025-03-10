using System;
using System.Collections.Generic;

namespace api.Models.Game;

public partial class CrmBankAccount
{
    public int CrmId { get; set; }

    public string CrmIban { get; set; } = null!;

    public int CrmBalance { get; set; }

    public string CrmOwner { get; set; } = null!;

    public string CrmName { get; set; } = null!;

    public string CrmType { get; set; } = null!;

    public int CrmFrozen { get; set; }

    public string CrmMembers { get; set; } = null!;

    public int CrmScore { get; set; }

    public DateTime CrmCreation { get; set; }
}
