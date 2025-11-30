import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/entities/game_data.dart';
import '../../domain/usecases/create_new_game.dart';
import '../../domain/usecases/fetch_planet_names.dart';
import '../../domain/usecases/load_game.dart';
import '../../domain/usecases/save_game.dart';

class GameController extends ChangeNotifier {
  final LoadGame loadGame;
  final SaveGame saveGame;
  final CreateNewGame createNewGame;
  final FetchPlanetNames fetchPlanetNames;

  GameData? _gameData;
  GameData? get gameData => _gameData;

  Timer? _resourceTimer;

  GameController({
    required this.loadGame,
    required this.saveGame,
    required this.createNewGame,
    required this.fetchPlanetNames,
  });

  Future<bool> checkExistingGame() async {
    final result = await loadGame();
    return result.fold((failure) => false, (data) {
      _gameData = data;
      return true;
    });
  }

  Future<GameData?> loadExistingGame() async {
    final result = await loadGame();
    return result.fold((failure) => null, (data) {
      _gameData = data;
      startResourceTimer();
      return data;
    });
  }

  Future<GameData?> createGame(String playerName) async {
    final planetNamesResult = await fetchPlanetNames();

    return await planetNamesResult.fold((failure) => null, (planetNames) async {
      final result = await createNewGame(playerName, planetNames);
      return result.fold((failure) => null, (data) {
        _gameData = data;
        startResourceTimer();
        return data;
      });
    });
  }

  void startResourceTimer() {
    _resourceTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_gameData != null) {
        for (var planet in _gameData!.planets) {
          planet.updateResources();
        }
        saveGameData();
        notifyListeners();
      }
    });
  }

  Future<void> saveGameData() async {
    if (_gameData != null) {
      await saveGame(_gameData!);
    }
  }

  @override
  void dispose() {
    _resourceTimer?.cancel();
    super.dispose();
  }
}
