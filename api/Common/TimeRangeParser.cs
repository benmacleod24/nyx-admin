namespace api.Common
{
    public static class TimeRangeParser
    {
        public static (DateTime Start, DateTime End)? ParseRange(string? range, string? start, string? end)
        {
            if (!string.IsNullOrWhiteSpace(range))
            {
                var unit = range[^1]; // Last character represents the unit (h, d, w, m, y)
                if (int.TryParse(range[..^1], out int value))
                {
                    var endDate = DateTime.UtcNow;
                    var startDate = unit switch
                    {
                        'h' => endDate.AddHours(-value),
                        'd' => endDate.AddDays(-value),
                        'w' => endDate.AddDays(-value * 7),
                        'm' => endDate.AddDays(-value * 30), // Approximate month as 30 days
                        'y' => endDate.AddDays(-value * 365), // Approximate year as 365 days
                        _ => (DateTime?)null
                    };

                    if (startDate != null)
                        return (startDate.Value, endDate);
                }
            }

            // Try parsing custom start and end dates
            if (DateTime.TryParse(start, out var startDateTime) &&
                DateTime.TryParse(end, out var endDateTime))
            {
                if (startDateTime < endDateTime)
                    return (startDateTime, endDateTime);
            }

            return null;
        }
    }
}
