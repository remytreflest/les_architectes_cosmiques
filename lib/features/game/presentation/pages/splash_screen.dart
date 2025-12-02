import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../controllers/game_controller.dart';
import 'main_game_screen.dart';
import 'onboarding_page.dart';
import 'player_name_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkGame();
  }

  Future<void> _checkGame() async {
    await Future.delayed(const Duration(seconds: 1));

    final controller = sl<GameController>();
    final gameData = await controller.loadExistingGame();

    if (!mounted) return;

    if (gameData != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainGameScreen(controller: controller),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => OnboardingScreen(nextPage: PlayerNameScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rocket_launch, size: 100, color: Colors.blue[300]),
            const SizedBox(height: 20),
            const Text(
              'Space Empire',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
