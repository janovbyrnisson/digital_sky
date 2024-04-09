import 'package:digital_sky_common/src/domain/game_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_service.g.dart';

@Riverpod(keepAlive: true)
class GameService extends _$GameService {
  @override
  GameState build() {
    return const GameState(started: "false", wave: "");
  }

  void startGame() {
    state = state.copyWith(started: "true");
  }

  void stopGame() {
    state = state.copyWith(started: "false");
  }

  void setWave(String wave) {
    state = state.copyWith(wave: wave, questionId: "");
  }

  void setQuestion(String questionId) {
    state = state.copyWith(questionId: questionId);
  }
}
