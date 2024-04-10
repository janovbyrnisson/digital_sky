// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      started: json['started'] as String,
      wave: json['wave'] as String,
      questionId: json['questionId'] as String? ?? "",
      question: json['question'] as String? ?? "",
      answer1: json['answer1'] as String? ?? "",
      answer2: json['answer2'] as String? ?? "",
      answer3: json['answer3'] as String? ?? "",
      alreadyAnswered: json['alreadyAnswered'] as String? ?? "",
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'started': instance.started,
      'wave': instance.wave,
      'questionId': instance.questionId,
      'question': instance.question,
      'answer1': instance.answer1,
      'answer2': instance.answer2,
      'answer3': instance.answer3,
      'alreadyAnswered': instance.alreadyAnswered,
    };
