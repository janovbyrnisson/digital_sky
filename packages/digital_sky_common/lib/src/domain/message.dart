import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum MessageType {
  ping,
  masterJoin,
  playerJoin,
  playerJoinFinished,
  playerList,
  playerLeft,
}

@freezed
abstract class Message with _$Message {
  const factory Message({
    @Default(null) String? id,
    @Default(null) String? clientId,
    @Default("*") String target,
    required MessageType type,
    required String content,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
