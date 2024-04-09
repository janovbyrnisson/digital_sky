import 'package:digital_sky_player/application/providers/game_state_provider.dart';
import 'package:digital_sky_player/presentation/shared/question.dart';
import 'package:digital_sky_player/presentation/shared/wave_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameServiceProvider);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/background.webp", fit: BoxFit.cover)),
          if (gameState!.started == "false")
            const Center(
              child: Text(
                "Game is stopped, waiting for master to resume the game.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 21,
                ),
              ),
            )
          else if (gameState.wave.isNotEmpty) ...[
            if (gameState.questionId.isEmpty)
              Center(
                child: WaveText(
                  text: "Wave ${gameState.wave}",
                  animate: true,
                ),
              )
            else
              const Center(
                child: Question(
                  animate: true,
                  delayDuration: Duration(milliseconds: 200),
                ),
              ),
          ] else
            Center(
              child: SizedBox(width: 140, child: Image.asset("assets/images/sunny.gif", fit: BoxFit.cover)),
            ),
        ],
      ),
    );
  }
}
