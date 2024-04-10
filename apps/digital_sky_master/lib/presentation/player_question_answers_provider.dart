import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_question_answers_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerQuestionAnswers extends _$PlayerQuestionAnswers {
  @override
  Map<String, Map<String, bool>> build() {
    return {};
  }

  bool addPlayerAnswer(String clientId, String questionId, bool answer) {
    state.putIfAbsent(questionId, () => {});
    if (!state[questionId]!.containsKey(clientId)) {
      state[questionId]![clientId] = answer;
      state = {...state};
      return true;
    }
    return false;
  }

  bool playerAnswered(String clientId, String questionId) {
    return state.containsKey(questionId) && state[questionId]!.containsKey(clientId);
  }
}
