import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_master/application/game_service.dart';
import 'package:digital_sky_master/domain/player.dart';
import 'package:digital_sky_master/presentation/player_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'master_service.g.dart';

@Riverpod(keepAlive: true)
MasterService masterService(MasterServiceRef ref) {
  return MasterService(ref);
}

class MasterService {
  MasterService(this.ref) : _communicationChannel = ref.read(communicationChannelProvider);

  final MasterServiceRef ref;
  final DigitalSkyCommunicationChannel _communicationChannel;

  void init() {
    _communicationChannel
      ..addMessageListener(MessageType.ping, _onPlayerPing)
      ..addMessageListener(MessageType.playerJoin, _onPlayerJoin)
      ..addMessageListener(MessageType.playerLeft, _onPlayerLeave);
  }

  void _onPlayerJoin(Message message) {
    print("MASTER SAYS: Player joined: ${message.clientId}");
    ref
        .read(playerListProvider.notifier)
        .addPlayer(Player(clientId: message.clientId!, name: message.content, status: PlayerStatus.present));
    sendGameUpdate();
  }

  void _onPlayerPing(Message message) {
    print("MASTER SAYS: Player pinged me! ${message.clientId}");
    ref.read(playerListProvider.notifier).setPlayerStatus(message.clientId!, PlayerStatus.present);
    sendGameUpdate();
  }

  void _onPlayerLeave(Message message) {
    print("MASTER SAYS: Player left the game! ${message.clientId}");
    ref.read(playerListProvider.notifier).setPlayerStatus(message.clientId!, PlayerStatus.idle);
  }

  void sendGameUpdate() {
    print("Sending game update...");
    _communicationChannel.sendMessage(
      Message(
        type: MessageType.gameUpdate,
        content: ref.read(gameServiceProvider).toQueryString(),
      ),
    );
  }
}
