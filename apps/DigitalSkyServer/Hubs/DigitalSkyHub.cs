using Microsoft.AspNetCore.SignalR;

namespace DigitalSky.Hubs
{
    public class DigitalSkyHub : Hub
    {
        public async Task SendMessage(string message)
        {
            Console.WriteLine($"[HUB] Message: {message}");
            await Clients.Others.SendAsync("ReceiveMessage", message);
        }
    }
}