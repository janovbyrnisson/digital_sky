import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_name_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerName extends _$PlayerName {
  @override
  String? build() {
    return null;
  }

  void setPlayerName(String name) {
    state = name;
  }
}
