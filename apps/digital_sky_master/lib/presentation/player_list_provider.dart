import 'package:digital_sky_master/domain/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_list_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerList extends _$PlayerList {
  @override
  List<Player> build() {
    return [];
  }

  void addPlayer(Player player) {
    final newList = [...state, player];
    state = newList;
  }

  void removePlayer(String clientId) {
    final newList = state.where((element) => element.clientId != clientId).toList();
    state = newList;
  }

  void setPlayerStatus(String clientId, PlayerStatus status) {
    final newList = state.map((e) {
      if (e.clientId == clientId) {
        return e.copyWith(status: status);
      }
      return e;
    }).toList();
    state = newList;
  }
}
