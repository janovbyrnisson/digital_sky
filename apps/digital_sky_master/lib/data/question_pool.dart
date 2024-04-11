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
    //
    //  WAVE 1
    //
    Question(
      id: "4d09c575-2fb6-4340-bff1-a8e2ab96c73f",
      question: "What encryption algorithm is used in the Digital Sky?",
      options: [
        "AES256-GCM",
        "Asymmetric",
        "No encryption is used",
      ],
      answer: 0,
      wave: 1,
    ),
    //
    //  WAVE 2
    //
    Question(
      id: "3ed470b0-820c-4df3-9a26-e9067bd51ec7",
      question:
          "The practice of using a network of remote servers hosted on the internet to store, manage, and process data is..",
      options: [
        "Network routing",
        "Cloud computing",
        "Data mining",
      ],
      answer: 1,
      wave: 2,
    ),
    Question(
      id: "c22d187f-2027-405e-a580-fbcecfec5ef9",
      question: "Which of the following is a primary concern in Cloud Security?",
      options: [
        "Device security",
        "Vendor lock-in",
        "Unathorized data access",
      ],
      answer: 2,
      wave: 2,
    ),
    Question(
      id: "47b500b4-f560-4649-be5d-4a5024deb99c",
      question: "How do we call when a single instance of software that serves multiple tenant clients or users?",
      options: [
        "Multibroker",
        "Multitenancy",
        "Service Bus",
      ],
      answer: 1,
      wave: 2,
    ),
    //
    //  WAVE 3
    //
    Question(
      id: "a04369db-6314-48a5-a497-9c405ca122ca",
      question: "What is the primary purpose of encryption in cloud security?",
      options: [
        "Increase Speed",
        "Provide readable data",
        "Protect data",
      ],
      answer: 2,
      wave: 3,
    ),
    Question(
      id: "d64472da-4a40-4a89-a44f-a6938594f4ff",
      question: "What does Multi-Factor Authentication (MFA) provide in cloud security?",
      options: [
        "Single password access",
        "Additional layers of security",
        "Data recovery services",
      ],
      answer: 1,
      wave: 3,
    ),
    Question(
      id: "33b7174f-d6b8-4139-a0ef-3ff6eb9904a9",
      question: "What kind of cloud environment does the term 'Public Cloud' refer to?",
      options: [
        "Single-organization",
        "Very public",
        "Multi-tenant",
      ],
      answer: 2,
      wave: 3,
    ),
    //
    //  WAVE 4
    //
    Question(
      id: "e3f1d99e-d811-4e4d-822b-1374a008021a",
      question: "Which type of data is most vulnerable to data breaches?",
      options: [
        "Data at rest",
        "Data at transit",
        "Both",
      ],
      answer: 2,
      wave: 4,
    ),
    Question(
      id: "353805df-f553-4433-960e-e747d1ce66a2",
      question: "What is the primary purpose of Identity and Access Management (IAM) in an organization?",
      options: [
        "User Access Control",
        "Employee monitoring",
        "Performance tracking",
      ],
      answer: 0,
      wave: 4,
    ),
    Question(
      id: "0a55d6c4-9544-4aff-a2ff-f5e7148d39cb",
      question: "What is first line of defense when blocking intruders in cloud?",
      options: [
        "Space shields",
        "Firewalls",
        "Stone walls",
      ],
      answer: 1,
      wave: 4,
    ),
  ];
}
