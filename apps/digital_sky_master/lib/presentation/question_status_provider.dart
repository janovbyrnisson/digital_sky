import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_status_provider.g.dart';

@Riverpod(keepAlive: true)
class QuestionStatus extends _$QuestionStatus {
  @override
  Map<String, bool> build() {
    return {};
  }

  void setQuestionStatus(String questionId, bool status) {
    state[questionId] = status;
    state = {...state};
  }

  bool getQuestionStatus(String questionId) => state.containsKey(questionId) ? state[questionId]! : false;
}
