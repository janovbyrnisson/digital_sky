import 'dart:convert';

import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_player/application/providers/game_state_provider.dart';
import 'package:digital_sky_player/application/providers/player_name_provider.dart';
import 'package:digital_sky_player/presentation/game/game_screen.dart';
import 'package:digital_sky_player/presentation/shared/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  bool _isJoining = false;
  bool _joinAllowed = false;
  bool _joinSuccess = false;
  String _encryptedName = "";

  void _join() async {
    setState(() {
      _isJoining = true;
    });

    ref.read(communicationChannelProvider).addMessageListener(MessageType.playerJoinFinished, _onJoinFinished);
    ref.read(communicationChannelProvider).addMessageListener(MessageType.gameUpdate, _onInitialGameUpdate);

    await ref
        .read(communicationChannelProvider)
        .sendMessage(Message(type: MessageType.playerJoin, content: _nameEditingController.text));
  }

  void _onJoinFinished(Message message) async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isJoining = false;
      _joinSuccess = true;
      _encryptedName = message.content;
    });

    ref.read(communicationChannelProvider).removeMessageListener(MessageType.playerJoin, _onJoinFinished);
    ref.read(playerNameProvider.notifier).setPlayerName(_nameEditingController.text);
  }

  void _onInitialGameUpdate(Message message) async {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      final gameState = GameState.fromQueryString(message.content);
      if (gameState.started == "true") {
        ref.read(communicationChannelProvider).removeMessageListener(MessageType.gameUpdate, _onInitialGameUpdate);
        ref.read(gameServiceProvider.notifier).init(gameState);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GameScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/background.webp", fit: BoxFit.cover)),
          const Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Logo(
              animate: false,
            ),
          ),
          if (!_joinSuccess)
            Positioned(
              top: 250,
              left: 30,
              right: 30,
              height: 200,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Enter you name below:",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextField(
                      controller: _nameEditingController,
                      onChanged: (value) => setState(() {
                        _joinAllowed = value.isNotEmpty;
                      }),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: "Your Name",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: !_isJoining && _joinAllowed ? _join : null,
                      child: Text(
                        _isJoining ? "Joining..." : "Join",
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Positioned(
              top: 250,
              left: 30,
              right: 30,
              bottom: 30,
              child: Column(
                children: [
                  Text(
                    "Welcome, ${_nameEditingController.text}!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 20,
                  ),
                  const Text(
                    "Please wait for the Master to start the game.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox.square(dimension: 20),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Icon(Icons.info),
                            const Text(
                              "Your name encrypted:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox.square(dimension: 20),
                            SelectableRegion(
                              focusNode: FocusNode(),
                              selectionControls: MaterialTextSelectionControls(),
                              child: Text(
                                utf8.decode(base64Decode(_encryptedName)),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
