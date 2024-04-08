import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_master/application/master_service.dart';
import 'package:digital_sky_master/domain/player.dart';
import 'package:digital_sky_master/presentation/player_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    ref.read(masterServiceProvider).init();
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playerListProvider);

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 30,
                    color: Colors.blueGrey.shade500,
                    padding: const EdgeInsets.all(4),
                    child: const Text(
                      "Player List",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: players
                          .map((player) => ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: player.status == PlayerStatus.present ? Colors.green : Colors.amber,
                                ),
                                title: Text(player.name),
                                subtitle: Text(
                                  player.clientId,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 350,
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.blueGrey.shade100,
                child: Center(
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
            ),
          ],
        ),
      ),
    );
  }
}
