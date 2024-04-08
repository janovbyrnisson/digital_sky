import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';

enum PlayerStatus { idle, present }

@freezed
class Player with _$Player {
  const factory Player({
    required String clientId,
    required String name,
    required PlayerStatus status,
  }) = _Player;
}
