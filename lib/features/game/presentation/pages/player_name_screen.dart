import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../controllers/game_controller.dart';
import 'main_game_screen.dart';

class PlayerNameScreen extends StatefulWidget {
  const PlayerNameScreen({Key? key}) : super(key: key);

  @override
  State<PlayerNameScreen> createState() => _PlayerNameScreenState();
}

class _PlayerNameScreenState extends State<PlayerNameScreen> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _startGame() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() => _isLoading = true);

    final gameController = sl<GameController>();
    final gameData = await gameController.createGame(_controller.text.trim());

    if (!mounted) return;

    if (gameData != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainGameScreen(controller: gameController),
        ),
      );
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la création du jeu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 80, color: Colors.blue),
              const SizedBox(height: 30),
              const Text(
                'Bienvenue, Commandant',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Quel est votre nom ?',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Nom du joueur',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.account_circle),
                ),
                textCapitalization: TextCapitalization.words,
                onSubmitted: (_) => _startGame(),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _startGame,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Commencer l\'aventure',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              if (_isLoading) ...[
                const SizedBox(height: 20),
                const Text(
                  'Chargement du système solaire...',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
