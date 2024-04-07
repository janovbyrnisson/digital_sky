using System.Text.Json;
using DigitalSky.Domain;
using DigitalSkyServer.Services;
using Microsoft.AspNetCore.SignalR;

namespace DigitalSky.Hubs
{
    public class DigitalSkyHub : Hub
    {
        protected readonly DigitalSkyBrokerService _brokerService;

        public DigitalSkyHub(DigitalSkyBrokerService brokerService)
        {
            _brokerService = brokerService;
        }

        public async Task SendMessage(string jsonMessage)
        {
            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            };

            var message = JsonSerializer.Deserialize<Message>(jsonMessage, options);
            Console.WriteLine($"[HUB] Message: {message?.Type} :: {message?.Content}");

            if (message?.Type == "masterJoin")
            {
                _brokerService.JoinMaster(message.ClientId, Clients.Caller);
                await Clients.Others.SendAsync("ReceiveMessage", jsonMessage);
            }
            else if (message?.Type == "playerJoin")
            {
                _brokerService.JoinPlayer(message.ClientId, Clients.Caller);
                await _brokerService.MasterProxy!.SendAsync("ReceiveMessage", jsonMessage);
            }
            else
            {
                await Clients.Others.SendAsync("ReceiveMessage", jsonMessage);
            }
        }
    }
}