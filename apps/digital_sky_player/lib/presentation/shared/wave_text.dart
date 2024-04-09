import 'package:flutter/material.dart';

class WaveText extends StatefulWidget {
  const WaveText({
    super.key,
    required this.text,
    required this.animate,
    this.delayDuration = Duration.zero,
  });

  final bool animate;
  final Duration delayDuration;
  final String text;

  @override
  State<WaveText> createState() => _WaveTextState();
}

class _WaveTextState extends State<WaveText> with SingleTickerProviderStateMixin {
  double _scale = 1;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _waitAndAnimate();
    }
  }

  @override
  void didUpdateWidget(covariant WaveText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animate) {
      _waitAndAnimate();
    }
  }

  void _waitAndAnimate() async {
    await Future.delayed(widget.delayDuration);
    setState(() {
      _scale = 0.5;
      _opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 100),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
          width: 1000,
          child: Text(
            widget.text,
            softWrap: false,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 100, color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
