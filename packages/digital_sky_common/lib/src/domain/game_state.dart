import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GameStateStatus { idle, present }

@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required String started,
    required String wave,
    @Default("") String questionId,
    @Default("") String question,
    @Default("") String answer1,
    @Default("") String answer2,
    @Default("") String answer3,
    @Default("") String alreadyAnswered,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

  factory GameState.fromQueryString(String query) => GameState.fromJson(Uri.splitQueryString(query));

  String toQueryString() {
    return Uri(queryParameters: toJson()).query;
  }
}
