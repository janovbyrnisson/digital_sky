import 'package:flutter/material.dart';

class AppStyles {
  static final answerButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.grey.shade50),
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 25, color: Colors.purple.shade900)),
  );
  static final answerSelectedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.purple.shade100),
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 25, color: Colors.purple.shade900)),
  );
  static final answerCorrectButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green.shade300),
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 25, color: Colors.purple.shade900)),
  );
  static final answerIncorrectButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red.shade200),
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 25, color: Colors.purple.shade900)),
  );
}
