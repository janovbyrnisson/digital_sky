
using DigitalSky.Hubs;
using Microsoft.AspNetCore.SignalR;

namespace DigitalSkyServer.Services
{
    public class DigitalSkyBrokerService
    {
        public string MasterId { get; private set; } = "";
        public IClientProxy? MasterProxy { get; private set; } = null;

        Dictionary<string, ISingleClientProxy> _players = new Dictionary<string, ISingleClientProxy>();

        public void JoinPlayer(string clientId, ISingleClientProxy player)
        {
            _players.Add(clientId, player);
            Console.WriteLine($"[BROKER] Player joined: {clientId}");
        }

        public void JoinMaster(string clientId, IClientProxy master)
        {
            MasterId = clientId;
            MasterProxy = master;
            Console.WriteLine($"[BROKER] Master joined: {clientId}");
        }

        // public async Task SendMessage(Message message)
        // {
        //     var jsonMessage = JsonSerializer.Serialize(message);
        //     await _hubContext.Clients.All.SendAsync("ReceiveMessage", jsonMessage);
        // }
    }
}