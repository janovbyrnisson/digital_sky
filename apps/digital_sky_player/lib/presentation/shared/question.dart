import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_player/application/providers/player_score_provider.dart';
import 'package:digital_sky_player/application/styles/app_styles.dart';
import 'package:digital_sky_player/presentation/shared/gained_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Question extends ConsumerStatefulWidget {
  const Question({
    super.key,
    required this.gameState,
    required this.animate,
    this.delayDuration = Duration.zero,
  });

  final bool animate;
  final Duration delayDuration;
  final GameState gameState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<Question> {
  double _opacity = 0;
  List<ButtonStyle> _answerButtonStyles = [
    AppStyles.answerButtonStyle,
    AppStyles.answerButtonStyle,
    AppStyles.answerButtonStyle,
  ];
  int _selectedAnswer = -1;
  bool _interactionAllowed = true;
  String _currentQuestionId = "";
  Widget? _gainedScore;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _currentQuestionId = widget.gameState.questionId;
    _stopwatch.reset();
    _stopwatch.start();
    if (widget.animate) {
      _waitAndAnimate();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Question oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_currentQuestionId != widget.gameState.questionId) {
      _stopwatch.reset();
      _stopwatch.start();
    }

    setState(() {
      _opacity = 0;
      _resetSelected();
    });
    if (widget.animate) {
      _waitAndAnimate();
    }
  }

  void _waitAndAnimate() async {
    await Future.delayed(widget.delayDuration);
    setState(() {
      _opacity = 1;
    });
  }

  void _resetSelected() {
    if (_currentQuestionId != widget.gameState.questionId) {
      _gainedScore = null;
      _currentQuestionId = widget.gameState.questionId;
      _interactionAllowed = true;
      _selectedAnswer = -1;
      _answerButtonStyles = [
        AppStyles.answerButtonStyle,
        AppStyles.answerButtonStyle,
        AppStyles.answerButtonStyle,
      ];
    }
  }

  void _onAnswerSelected(int index) {
    if (!_interactionAllowed) {
      return;
    }
    ref.read(communicationChannelProvider).addMessageListener(MessageType.questionResult, _handleQuestionResult);

    final time = _stopwatch.elapsedMilliseconds;
    _stopwatch.stop();

    setState(() {
      for (var i = 0; i < _answerButtonStyles.length; i++) {
        if (i == index) {
          _answerButtonStyles[i] = AppStyles.answerSelectedButtonStyle;
          _selectedAnswer = i;
        } else {
          _answerButtonStyles[i] = AppStyles.answerButtonStyle;
        }
      }
      _interactionAllowed = false;
    });

    ref.read(communicationChannelProvider).sendMessage(
          Message(
            type: MessageType.playerAnswer,
            content: "questionId=$_currentQuestionId&answer=${_selectedAnswer.toString()}&t=$time",
          ),
        );
  }

  void _handleQuestionResult(Message message) {
    print("Checking Target: ${message.target} == ${ref.read(communicationChannelProvider).clientId}");
    if (message.target != ref.read(communicationChannelProvider).clientId) {
      return;
    }

    final parts = Uri.splitQueryString(message.content);
    final isCorrect = parts['correct'] == 'true';
    final correctAnswer = int.parse(parts['correctAnswer']!);
    final score = int.parse(parts['score']!);
    final totalScore = int.parse(parts['totalScore']!);
    final questionId = parts['questionId']!;

    print("Handle Question Result: $_currentQuestionId == $questionId");

    if (questionId == _currentQuestionId) {
      ref.read(playerScoreProvider.notifier).setPlayerScore(totalScore);
      setState(() {
        _gainedScore = GainedScore(
          animate: true,
          score: score,
          delayDuration: const Duration(seconds: 1),
        );
        _answerButtonStyles[correctAnswer] = AppStyles.answerCorrectButtonStyle;
        if (!isCorrect) {
          _answerButtonStyles[_selectedAnswer] = AppStyles.answerIncorrectButtonStyle;
        }
      });
    }
    ref.read(communicationChannelProvider).removeMessageListener(MessageType.questionResult, _handleQuestionResult);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Stack(
          children: [
            Positioned(
              top: 140,
              left: 0,
              right: 0,
              bottom: 100,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.gameState.question,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () => _onAnswerSelected(0),
                        style: _answerButtonStyles[0],
                        child: Text(widget.gameState.answer1),
                      ),
                      ElevatedButton(
                        onPressed: () => _onAnswerSelected(1),
                        style: _answerButtonStyles[1],
                        child: Text(widget.gameState.answer2),
                      ),
                      ElevatedButton(
                        onPressed: () => _onAnswerSelected(2),
                        style: _answerButtonStyles[2],
                        child: Text(widget.gameState.answer3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_gainedScore == null)
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 280,
                  child: Image.asset("assets/images/bomb.gif"),
                ),
              ),
            if (_gainedScore != null)
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: _gainedScore!,
              ),
          ],
        ),
      ),
    );
  }
}
