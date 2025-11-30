import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/game_constants.dart';
import '../models/game_data_model.dart';

abstract class LocalStorageDataSource {
  Future<GameDataModel> loadGame();
  Future<void> saveGame(GameDataModel gameData);
  Future<bool> hasGame();
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  final SharedPreferences sharedPreferences;

  LocalStorageDataSourceImpl({required this.sharedPreferences});

  @override
  Future<GameDataModel> loadGame() async {
    final jsonString = sharedPreferences.getString(GameConstants.storageKey);
    if (jsonString != null) {
      return GameDataModel.fromJson(jsonDecode(jsonString));
    }
    throw Exception('No game data found');
  }

  @override
  Future<void> saveGame(GameDataModel gameData) async {
    await sharedPreferences.setString(
      GameConstants.storageKey,
      jsonEncode(gameData.toJson()),
    );
  }

  @override
  Future<bool> hasGame() async {
    return sharedPreferences.containsKey(GameConstants.storageKey);
  }
}
