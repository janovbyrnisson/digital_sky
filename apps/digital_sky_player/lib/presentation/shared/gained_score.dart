import 'package:flutter/material.dart';

class GainedScore extends StatefulWidget {
  const GainedScore({super.key, required this.animate, this.delayDuration = Duration.zero, required this.score});

  final int score;
  final bool animate;
  final Duration delayDuration;

  @override
  State<GainedScore> createState() => _GainedScoreState();
}

class _GainedScoreState extends State<GainedScore> with SingleTickerProviderStateMixin {
  Offset _offset = const Offset(0, 0);
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GainedScore oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animate) {
      _waitAndAnimate();
    }
  }

  void _waitAndAnimate() async {
    await Future.delayed(widget.delayDuration);
    setState(() {
      _offset = const Offset(0, -10);
      _opacity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _offset,
      duration: const Duration(milliseconds: 5000),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: Text(
          "${widget.score > 0 ? "+" : ""}${widget.score.toString()}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.score > 0 ? Colors.green : Colors.red,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
