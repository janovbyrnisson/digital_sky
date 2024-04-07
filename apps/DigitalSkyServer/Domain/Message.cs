namespace DigitalSky.Domain
{
    public class Message
    {
        public string Id{ get; set; } = "";
        public string ClientId{ get; set; } = "";
        public string Target{ get; set; } = "*";
        public string Type { get; set; } = "";
        public string Content { get; set; } = "";
    }
}