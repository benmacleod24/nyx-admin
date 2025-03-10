using System;
using System.Collections.Generic;

namespace api.Models.Game;

public partial class CrmBankLoan
{
    public int CrmId { get; set; }

    public string CrmIban { get; set; } = null!;

    public int CrmAmount { get; set; }

    public float CrmInterest { get; set; }

    public int CrmStatus { get; set; }

    public int CrmPayments { get; set; }

    public int CrmRemaining { get; set; }

    public float CrmRecurring { get; set; }

    public DateTime CrmCreated { get; set; }
}
