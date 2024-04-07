import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key, required this.animate, this.delayDuration = Duration.zero});

  final bool animate;
  final Duration delayDuration;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  Offset _offset = const Offset(0, 0);
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Logo oldWidget) {
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
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
