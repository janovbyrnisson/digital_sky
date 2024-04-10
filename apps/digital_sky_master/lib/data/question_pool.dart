import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_pool.g.dart';

class Question {
  final String id;
  final String question;
  final List<String> options;
  final int answer;
  final int wave;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
    required this.wave,
  });
}

@riverpod
List<Question> questionPool(QuestionPoolRef ref) {
  return [
    Question(
      id: "4d09c575-2fb6-4340-bff1-a8e2ab96c73f",
      question: "What is the capital of France?",
      options: [
        "Paris",
        "London",
        "Berlin",
      ],
      answer: 0,
      wave: 1,
    ),
    Question(
      id: "3ed470b0-820c-4df3-9a26-e9067bd51ec7",
      question: "Another question?",
      options: [
        "Option 1",
        "Option 2",
        "Option 3",
      ],
      answer: 2,
      wave: 2,
    ),
    Question(
      id: "c22d187f-2027-405e-a580-fbcecfec5ef9",
      question: "Yet another question?",
      options: [
        "Of course",
        "Nah",
        "Yay",
      ],
      answer: 0,
      wave: 2,
    ),
  ];
}
