// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  String get started => throw _privateConstructorUsedError;
  String get wave => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get answer1 => throw _privateConstructorUsedError;
  String get answer2 => throw _privateConstructorUsedError;
  String get answer3 => throw _privateConstructorUsedError;
  String get playerScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {String started,
      String wave,
      String questionId,
      String question,
      String answer1,
      String answer2,
      String answer3,
      String playerScore});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? started = null,
    Object? wave = null,
    Object? questionId = null,
    Object? question = null,
    Object? answer1 = null,
    Object? answer2 = null,
    Object? answer3 = null,
    Object? playerScore = null,
  }) {
    return _then(_value.copyWith(
      started: null == started
          ? _value.started
          : started // ignore: cast_nullable_to_non_nullable
              as String,
      wave: null == wave
          ? _value.wave
          : wave // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer1: null == answer1
          ? _value.answer1
          : answer1 // ignore: cast_nullable_to_non_nullable
              as String,
      answer2: null == answer2
          ? _value.answer2
          : answer2 // ignore: cast_nullable_to_non_nullable
              as String,
      answer3: null == answer3
          ? _value.answer3
          : answer3 // ignore: cast_nullable_to_non_nullable
              as String,
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String started,
      String wave,
      String questionId,
      String question,
      String answer1,
      String answer2,
      String answer3,
      String playerScore});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? started = null,
    Object? wave = null,
    Object? questionId = null,
    Object? question = null,
    Object? answer1 = null,
    Object? answer2 = null,
    Object? answer3 = null,
    Object? playerScore = null,
  }) {
    return _then(_$GameStateImpl(
      started: null == started
          ? _value.started
          : started // ignore: cast_nullable_to_non_nullable
              as String,
      wave: null == wave
          ? _value.wave
          : wave // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer1: null == answer1
          ? _value.answer1
          : answer1 // ignore: cast_nullable_to_non_nullable
              as String,
      answer2: null == answer2
          ? _value.answer2
          : answer2 // ignore: cast_nullable_to_non_nullable
              as String,
      answer3: null == answer3
          ? _value.answer3
          : answer3 // ignore: cast_nullable_to_non_nullable
              as String,
      playerScore: null == playerScore
          ? _value.playerScore
          : playerScore // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {required this.started,
      required this.wave,
      this.questionId = "",
      this.question = "",
      this.answer1 = "",
      this.answer2 = "",
      this.answer3 = "",
      this.playerScore = ""})
      : super._();

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  @override
  final String started;
  @override
  final String wave;
  @override
  @JsonKey()
  final String questionId;
  @override
  @JsonKey()
  final String question;
  @override
  @JsonKey()
  final String answer1;
  @override
  @JsonKey()
  final String answer2;
  @override
  @JsonKey()
  final String answer3;
  @override
  @JsonKey()
  final String playerScore;

  @override
  String toString() {
    return 'GameState(started: $started, wave: $wave, questionId: $questionId, question: $question, answer1: $answer1, answer2: $answer2, answer3: $answer3, playerScore: $playerScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.started, started) || other.started == started) &&
            (identical(other.wave, wave) || other.wave == wave) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer1, answer1) || other.answer1 == answer1) &&
            (identical(other.answer2, answer2) || other.answer2 == answer2) &&
            (identical(other.answer3, answer3) || other.answer3 == answer3) &&
            (identical(other.playerScore, playerScore) ||
                other.playerScore == playerScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, started, wave, questionId,
      question, answer1, answer2, answer3, playerScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {required final String started,
      required final String wave,
      final String questionId,
      final String question,
      final String answer1,
      final String answer2,
      final String answer3,
      final String playerScore}) = _$GameStateImpl;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  String get started;
  @override
  String get wave;
  @override
  String get questionId;
  @override
  String get question;
  @override
  String get answer1;
  @override
  String get answer2;
  @override
  String get answer3;
  @override
  String get playerScore;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
