namespace api.Common.Responses
{
    public class ApiErrorResponse
    {
        public string Message { get; set; }
        public string ErrorType { get; set; } = "UnknownError";
        public int StatusCode { get; set; }
        public Dictionary<string, string[]> Errors { get; private set; } = new Dictionary<string, string[]> { };

    }
}
