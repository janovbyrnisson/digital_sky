import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_state_provider.g.dart';

@Riverpod(keepAlive: true)
class GameService extends _$GameService {
  @override
  GameState? build() {
    ref.read(communicationChannelProvider).addMessageListener(MessageType.gameUpdate, _gameUpdate);
    return null;
  }

  void init(GameState gameState) {
    state = gameState;
  }

  void _gameUpdate(Message message) {
    state = GameState.fromQueryString(message.content);
  }
}
