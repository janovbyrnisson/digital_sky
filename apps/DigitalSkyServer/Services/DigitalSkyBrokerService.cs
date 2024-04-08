
using DigitalSky.Hubs;
using Microsoft.AspNetCore.SignalR;

namespace DigitalSkyServer.Services
{
    public class DigitalSkyBrokerService
    {
        public string MasterConnectionId { get; private set; } = "";
        public string MasterId { get; private set; } = "";
        public string Master { get; private set; } = "";

        Dictionary<string, string> _playerConnectionMap = new Dictionary<string, string>();
        Dictionary<string, string> _players = new Dictionary<string, string>();

        public void JoinPlayer(string clientId, string playerUserId, string connectionId)
        {
            _players[clientId] = playerUserId;
            _playerConnectionMap[connectionId] = clientId;
            Console.WriteLine($"[BROKER] Player joined: {clientId} :: {connectionId}");
        }

        public void JoinMaster(string clientId, string masterUserId, string conenctionId)
        {
            MasterConnectionId = conenctionId;
            MasterId = clientId;
            Master = masterUserId;
            Console.WriteLine($"[BROKER] Master joined: {clientId}");
        }

        public string Player(string clientId)
        {
            return _players[clientId];
        }

        public void RemovePlayer(string clientId)
        {
            _players.Remove(clientId);
            _playerConnectionMap.Remove(_playerConnectionMap.FirstOrDefault(x => x.Value == clientId).Key);
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