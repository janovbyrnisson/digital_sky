using System.Text.Json;
using DigitalSky.Domain;
using DigitalSkyServer.Extensions;
using DigitalSkyServer.Services;
using Microsoft.AspNetCore.SignalR;

namespace DigitalSky.Hubs
{
    public class DigitalSkyHub : Hub
    {
        protected readonly AwsCryptoService _cryptoService;
        protected readonly DigitalSkyBrokerService _brokerService;

        public DigitalSkyHub(DigitalSkyBrokerService brokerService, AwsCryptoService cryptoService)
        {
            _brokerService = brokerService;
            _cryptoService = cryptoService;
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
                _brokerService.JoinMaster(message.ClientId, Context.UserIdentifier!, Context.ConnectionId);
                await Clients.Others.SendAsync("ReceiveMessage", jsonMessage);
            }
            else if (message?.Type == "playerJoin")
            {
                _brokerService.JoinPlayer(message.ClientId, Context.UserIdentifier!, Context.ConnectionId);
                await Clients.User(_brokerService.Master!).SendAsync("ReceiveMessage", jsonMessage);

                var encryptedName = "";

                using (var stream = message.Content.ToMemoryStream())
                {
                    encryptedName = _cryptoService.Encrypt(stream);
                }

                var encryptedJsonMessage = JsonSerializer.Serialize(new Message
                {
                    Id = System.Guid.NewGuid().ToString(),
                    Type = "playerJoinFinished",
                    ClientId = message.ClientId,
                    Content = encryptedName.ToBase64()
                }, options);
                await Clients.Caller.SendAsync("ReceiveMessage", encryptedJsonMessage);
            }
            else if(message?.Type == "questionResult")
            {
                Console.WriteLine($"[HUB] Question result sent to: {message.Target}");
                await Clients.User(_brokerService.Player(message.Target)).SendAsync("ReceiveMessage", jsonMessage);
            }
            else
            {
                await Clients.Others.SendAsync("ReceiveMessage", jsonMessage);
            }
        }

        public override Task OnConnectedAsync()
        {
            Console.WriteLine($"[HUB] Connection established: {Context.ConnectionId} {Context.UserIdentifier}");
            // Add your own code here.
            // For example: in a chat application, record the association between
            // the current connection ID and user name, and mark the user as online.
            // After the code in this method completes, the client is informed that
            // the connection is established; for example, in a JavaScript client,
            // the start().done callback is executed.
            return base.OnConnectedAsync();
        }

        public override Task OnDisconnectedAsync(Exception? exception)
        {
            var clientId = _brokerService.LookUpPlayerClientId(Context.ConnectionId);
            Console.WriteLine($"[HUB] Connection closed: {Context.ConnectionId} {clientId}");
            Clients.User(_brokerService.Master!).SendAsync("ReceiveMessage", JsonSerializer.Serialize(new Message
            {
                Id = System.Guid.NewGuid().ToString(),
                Type = "playerLeft",
                ClientId = clientId ?? "",
                Target = _brokerService.MasterId,
                Content = clientId ?? ""
            }, new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            }));
            // Add your own code here.
            // For example: in a chat application, mark the user as offline,
            // delete the association between the current connection id and user name.
            return base.OnDisconnectedAsync(exception);
        }
    }
}