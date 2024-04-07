import 'package:digital_sky_common/digital_sky_common.dart';
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

  void _join() async {
    setState(() {
      _isJoining = true;
    });

    ref.read(communicationChannelProvider).addMessageListener(MessageType.playerJoin, _onJoinFinished);

    await ref
        .read(communicationChannelProvider)
        .sendMessage(Message(type: MessageType.playerJoin, content: _nameEditingController.text));
  }

  void _onJoinFinished(Message message) async {
    await Future.delayed(const Duration(milliseconds: 500));

    print(message);

    setState(() {
      _isJoining = false;
    });
    ref.read(communicationChannelProvider).removeMessageListener(MessageType.playerJoin, _onJoinFinished);
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
        ],
      ),
    );
  }
}
