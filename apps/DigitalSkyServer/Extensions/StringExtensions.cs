namespace DigitalSkyServer.Extensions
{
    public static class StringExtensions
    {
        public static MemoryStream ToMemoryStream(this string str)
        {
            MemoryStream stream = new MemoryStream();
            StreamWriter writer = new StreamWriter(stream);
            writer.Write(str);
            writer.Flush();
            stream.Position = 0;
            return stream;
        }

        public static string ToBase64(this string str)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(str);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static string FromBase64(string base64Str)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64Str);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
    }
}