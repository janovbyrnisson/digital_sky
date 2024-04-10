import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_score_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerScore extends _$PlayerScore {
  @override
  Map<String, int> build() {
    return {};
  }

  int addPlayerScore(String clientId, int score) {
    if (!state.containsKey(clientId)) {
      state[clientId] = 0;
    }
    state[clientId] = state[clientId]! + score;
    state = {...state};
    return state[clientId]!;
  }
}
