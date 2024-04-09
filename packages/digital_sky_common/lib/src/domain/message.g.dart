// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String? ?? null,
      clientId: json['clientId'] as String? ?? null,
      target: json['target'] as String? ?? "*",
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      content: json['content'] as String,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'target': instance.target,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'content': instance.content,
    };

const _$MessageTypeEnumMap = {
  MessageType.ping: 'ping',
  MessageType.masterJoin: 'masterJoin',
  MessageType.playerJoin: 'playerJoin',
  MessageType.playerJoinFinished: 'playerJoinFinished',
  MessageType.playerList: 'playerList',
  MessageType.playerLeft: 'playerLeft',
  MessageType.gameUpdate: 'gameUpdate',
};
