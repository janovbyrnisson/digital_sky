import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    _connectToChannel();
  }

  void _connectToChannel() async {
    await ref.read(communicationChannelProvider).startConnection(isMaster: true);
    ref.read(communicationChannelProvider).sendMessage(const Message(type: MessageType.masterJoin, content: "juhu"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              ref
                  .read(communicationChannelProvider)
                  .sendMessage(const Message(type: MessageType.masterJoin, content: "juhu"));
            },
            child: const Text("Send Message"),
          ),
        ),
      ),
    );
  }
}
