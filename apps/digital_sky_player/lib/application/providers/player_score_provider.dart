import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_score_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerScore extends _$PlayerScore {
  @override
  int build() {
    return 0;
  }

  void setPlayerScore(int score) {
    state = score;
  }
}
