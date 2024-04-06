import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final DigitalSkyCommunicationChannel _digitalSkyCommunicationChannel = DigitalSkyCommunicationChannel();

  @override
  void initState() {
    super.initState();

    _digitalSkyCommunicationChannel.createConnection();
    _digitalSkyCommunicationChannel.startConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _digitalSkyCommunicationChannel.sendMessage("MASTER", 'Hello from MASTER');
            },
            child: const Text("Send Message"),
          ),
        ),
      ),
    );
  }
}
