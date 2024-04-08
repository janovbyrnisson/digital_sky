import 'package:digital_sky_common/digital_sky_common.dart';
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
      ..addMessageListener(MessageType.playerJoin, _onPlayerJoin)
      ..addMessageListener(MessageType.playerLeft, _onPlayerLeave);
  }

  void _onPlayerJoin(Message message) {
    ref
        .read(playerListProvider.notifier)
        .addPlayer(Player(clientId: message.clientId!, name: message.content, status: PlayerStatus.present));
  }

  void _onPlayerLeave(Message message) {
    print("MASTER SAYS: Player left the game! ${message.clientId}");
    ref.read(playerListProvider.notifier).setPlayerStatus(message.clientId!, PlayerStatus.idle);
  }
}
