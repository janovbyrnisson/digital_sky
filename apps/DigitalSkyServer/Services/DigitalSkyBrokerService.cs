
using DigitalSky.Hubs;
using Microsoft.AspNetCore.SignalR;

namespace DigitalSkyServer.Services
{
    public class DigitalSkyBrokerService
    {
        public string MasterConnectionId { get; private set; } = "";
        public string MasterId { get; private set; } = "";
        public IClientProxy? Master { get; private set; } = null;

        Dictionary<string, string> _playerConnectionMap = new Dictionary<string, string>();
        Dictionary<string, ISingleClientProxy> _players = new Dictionary<string, ISingleClientProxy>();

        public void JoinPlayer(string clientId, ISingleClientProxy player, string connectionId)
        {
            _players[clientId] = player;
            _playerConnectionMap[connectionId] = clientId;
            Console.WriteLine($"[BROKER] Player joined: {clientId} :: {connectionId}");
        }

        public void JoinMaster(string clientId, IClientProxy master, string conenctionId)
        {
            MasterConnectionId = conenctionId;
            MasterId = clientId;
            Master = master;
            Console.WriteLine($"[BROKER] Master joined: {clientId}");
        }

        public ISingleClientProxy Player(string clientId)
        {
            return _players[clientId];
        }

        public void RemovePlayer(string clientId)
        {
            _players.Remove(clientId);
            Console.WriteLine($"[BROKER] Player removed: {clientId}");
        }

        public string? LookUpPlayerClientId(string conenctionId)
        {
            if (_playerConnectionMap.ContainsKey(conenctionId))
            {
                return _playerConnectionMap[conenctionId];
            }
            return null;
        }

    }
}