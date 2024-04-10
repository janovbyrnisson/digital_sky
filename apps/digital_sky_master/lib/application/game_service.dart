import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_master/data/question_pool.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_service.g.dart';

@Riverpod(keepAlive: true)
class GameService extends _$GameService {
  @override
  GameState build() {
    return const GameState(started: "false", wave: "");
  }

  void startGame() {
    state = state.copyWith(started: "true");
  }

  void stopGame() {
    state = state.copyWith(started: "false");
  }

  void setWave(String wave) {
    state = state.copyWith(wave: wave, questionId: "");
  }

  void setQuestion(String questionId) {
    if (questionId.isNotEmpty) {
      final question = ref.read(questionPoolProvider).where((element) => element.id == questionId).first;
      state = state.copyWith(
        questionId: questionId,
        question: question.question,
        answer1: question.options[0],
        answer2: question.options[1],
        answer3: question.options[2],
      );
    } else {
      state = state.copyWith(
        questionId: "",
        question: "",
        answer1: "",
        answer2: "",
        answer3: "",
      );
    }
  }
}
