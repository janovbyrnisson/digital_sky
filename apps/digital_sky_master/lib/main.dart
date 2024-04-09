import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_master/application/game_service.dart';
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
  final List<String> _waves = ["", "1", "2", "3", "4", "5"];
  String _currentWave = "";

  @override
  void initState() {
    super.initState();
    _connectToChannel();
  }

  void _connectToChannel() async {
    await ref.read(communicationChannelProvider).startConnection(isMaster: true);
    ref
        .read(communicationChannelProvider)
        .sendMessage(const Message(type: MessageType.masterJoin, content: "Master joining"));
    ref.read(masterServiceProvider).init();
  }

  void _startGame() {
    ref.read(gameServiceProvider.notifier).startGame();
    ref.read(masterServiceProvider).sendGameUpdate();
  }

  void _stopGame() {
    ref.read(gameServiceProvider.notifier).stopGame();
    ref.read(masterServiceProvider).sendGameUpdate();
  }

  void _startWave() {
    ref.read(gameServiceProvider.notifier).setWave(_currentWave);
    ref.read(masterServiceProvider).sendGameUpdate();
  }

  void _stopWave() {
    ref.read(gameServiceProvider.notifier).setWave("");
    ref.read(masterServiceProvider).sendGameUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playerListProvider);
    final gameState = ref.watch(gameServiceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            //
            // PLAYERS LIST
            //
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 30,
                    color: Colors.blueGrey.shade500,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Player List :: ${players.length} players",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                                title: Text(
                                  player.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  player.clientId,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                dense: true,
                                onTap: () {},
                                trailing: Text("🪙 2356"),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            //
            // GAME PANEL
            //
            Positioned(
              left: 400,
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.blueGrey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
                    //  GAME STATE
                    //
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Wrap(
                        spacing: 10,
                        children: [
                          const Icon(Icons.games),
                          const Text(
                            "Current Game",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text("Started: ${gameState.started};"),
                          Text("Wave: ${gameState.wave};"),
                          Text("Question ID: ${gameState.questionId};"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blueGrey.shade50,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ElevatedButton(onPressed: _startGame, child: const Text("Start Game")),
                          ElevatedButton(onPressed: _stopGame, child: const Text("Stop Game")),
                          const SizedBox(width: 10),
                          ElevatedButton(onPressed: _startWave, child: const Text("Start Wave")),
                          DropdownButton<String>(
                            value: _currentWave,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            isDense: true,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _currentWave = value!;
                              });
                            },
                            items: _waves.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          ElevatedButton(onPressed: _stopWave, child: const Text("Stop Wave")),
                          ElevatedButton(
                              onPressed: () {
                                ref.read(gameServiceProvider.notifier).setQuestion("Q123");
                                ref.read(masterServiceProvider).sendGameUpdate();
                              },
                              child: const Text("Send Question")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
