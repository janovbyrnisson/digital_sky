import 'package:digital_sky_master/application/game_service.dart';
import 'package:digital_sky_master/data/question_pool.dart';
import 'package:digital_sky_master/presentation/player_list_provider.dart';
import 'package:digital_sky_master/presentation/player_question_answers_provider.dart';
import 'package:digital_sky_master/presentation/question_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsList extends ConsumerStatefulWidget {
  const QuestionsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionsListState();
}

class _QuestionsListState extends ConsumerState<QuestionsList> {
  List<(String, bool)> _getPlayerAnswersForQuestion(Map<String, Map<String, bool>> answers, String questionId) {
    if (!answers.containsKey(questionId)) {
      return [];
    }
    return answers[questionId]!.entries.map((e) {
      final p = ref.read(playerListProvider.notifier).getPlayer(e.key);
      return (p.name, e.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedQuestionId = ref.watch(gameServiceProvider).questionId;
    final questions = ref.watch(questionPoolProvider);
    final answers = ref.watch(playerQuestionAnswersProvider);
    final questionStatus = ref.watch(questionStatusProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: questions
          .map((e) => RadioListTile(
                value: e.id,
                groupValue: selectedQuestionId,
                title: Wrap(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: questionStatus.containsKey(e.id) && questionStatus[e.id]! ? Colors.green : Colors.black26,
                    ),
                    Text("[Wave ${e.wave}]"),
                    Text(
                      e.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.options.join(" | ")),
                  ],
                ),
                subtitle: Wrap(
                  spacing: 5,
                  children: _getPlayerAnswersForQuestion(answers, e.id).map((e) {
                    return Chip(
                      label: Text(e.$1),
                      labelPadding: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(2),
                      side: BorderSide.none,
                      backgroundColor: e.$2 ? Colors.greenAccent : Colors.amberAccent,
                    );
                  }).toList(),
                ),
                isThreeLine: true,
                onChanged: (value) {
                  ref.read(gameServiceProvider.notifier).setQuestion(value!);
                },
              ))
          .toList(),
    );
  }
}
