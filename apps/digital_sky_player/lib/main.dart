import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_player/presentation/login/login_screen.dart';
import 'package:digital_sky_player/presentation/shared/logo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  static const _kDelayDuration = Duration(milliseconds: 1500);

  bool _animateLogo = false;

  @override
  void initState() {
    super.initState();
    _connectToChannel();
  }

  void _connectToChannel() async {
    await ref.read(communicationChannelProvider).startConnection();
    setState(() {
      _animateLogo = true;
    });
    await Future.delayed(_kDelayDuration);
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/background.webp", fit: BoxFit.cover)),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Logo(
              animate: _animateLogo,
              delayDuration: const Duration(milliseconds: 500),
            ),
          ),
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Text(
                  "Init Sequence in progress...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
