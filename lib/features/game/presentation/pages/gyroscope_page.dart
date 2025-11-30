import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../domain/entities/planet.dart';

class GyroscopePage extends StatefulWidget {
  final Planet planet;
  final VoidCallback onReward;

  const GyroscopePage({Key? key, required this.planet, required this.onReward})
    : super(key: key);

  @override
  State<GyroscopePage> createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {
  double _x = 0;
  double _y = 0;
  double _z = 0;
  StreamSubscription<AccelerometerEvent>? _subscription;
  bool _isPlaying = false;
  int _score = 0;
  Timer? _gameTimer;

  @override
  void initState() {
    super.initState();
    _subscription = accelerometerEvents.listen((event) {
      if (mounted) {
        setState(() {
          _x = event.x;
          _y = event.y;
          _z = event.z;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _isPlaying = true;
      _score = 0;
    });

    _gameTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_isPlaying) {
        final movement = (_x.abs() + _y.abs() + _z.abs());
        if (movement > 15) {
          setState(() => _score++);
        }
      }
    });

    Future.delayed(const Duration(seconds: 10), () {
      if (_isPlaying) {
        _endGame();
      }
    });
  }

  void _endGame() {
    setState(() => _isPlaying = false);
    _gameTimer?.cancel();

    final reward = _score * 10;
    widget.planet.metal += reward;
    widget.planet.crystal += reward ~/ 2;
    widget.onReward();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Récompense !'),
        content: Text(
          'Score: $_score\nVous avez gagné:\n+$reward Métal\n+${reward ~/ 2} Cristal',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone_android, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Mini-Jeu Gyroscope',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'Secouez votre téléphone pendant 10 secondes !',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          if (!_isPlaying) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Données du gyroscope:'),
                    const SizedBox(height: 10),
                    Text('X: ${_x.toStringAsFixed(2)}'),
                    Text('Y: ${_y.toStringAsFixed(2)}'),
                    Text('Z: ${_z.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
              ),
              child: const Text('Commencer', style: TextStyle(fontSize: 18)),
            ),
          ] else ...[
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text('Secouez votre téléphone !'),
          ],
        ],
      ),
    );
  }
}
