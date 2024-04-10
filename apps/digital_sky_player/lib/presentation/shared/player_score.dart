import 'package:digital_sky_player/application/providers/player_score_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerScore extends ConsumerStatefulWidget {
  const PlayerScore({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends ConsumerState<PlayerScore> {
  @override
  Widget build(BuildContext context) {
    final score = ref.watch(playerScoreProvider);

    return Text(
      "😀 Score: $score",
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.amber, fontSize: 22),
    );
  }
}
