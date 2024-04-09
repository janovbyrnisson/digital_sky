import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Question extends ConsumerStatefulWidget {
  const Question({
    super.key,
    required this.animate,
    this.delayDuration = Duration.zero,
  });

  final bool animate;
  final Duration delayDuration;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<Question> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _waitAndAnimate();
    }
  }

  @override
  void didUpdateWidget(covariant Question oldWidget) {
    super.didUpdateWidget(oldWidget);

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Answer 1"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Answer 1"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Answer 1"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 280,
                child: Image.asset("assets/images/bomb.gif"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
