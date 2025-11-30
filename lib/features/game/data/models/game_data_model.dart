import '../../domain/entities/game_data.dart';
import 'planet_model.dart';

class GameDataModel extends GameData {
  GameDataModel({
    required String playerName,
    required List<PlanetModel> planets,
    required String activePlanetId,
    Map<String, int>? technologies,
    Map<String, int>? diplomacyTechs,
  }) : super(
         playerName: playerName,
         planets: planets,
         activePlanetId: activePlanetId,
         technologies: technologies,
         diplomacyTechs: diplomacyTechs,
       );

  Map<String, dynamic> toJson() => {
    'playerName': playerName,
    'planets': planets.map((p) => (p as PlanetModel).toJson()).toList(),
    'activePlanetId': activePlanetId,
    'technologies': technologies,
    'diplomacyTechs': diplomacyTechs,
  };

  factory GameDataModel.fromJson(Map<String, dynamic> json) => GameDataModel(
    playerName: json['playerName'],
    planets: (json['planets'] as List)
        .map((p) => PlanetModel.fromJson(p))
        .toList(),
    activePlanetId: json['activePlanetId'],
    technologies: Map<String, int>.from(json['technologies'] ?? {}),
    diplomacyTechs: Map<String, int>.from(json['diplomacyTechs'] ?? {}),
  );

  factory GameDataModel.fromEntity(GameData gameData) => GameDataModel(
    playerName: gameData.playerName,
    planets: gameData.planets.map((p) => PlanetModel.fromEntity(p)).toList(),
    activePlanetId: gameData.activePlanetId,
    technologies: gameData.technologies,
    diplomacyTechs: gameData.diplomacyTechs,
  );
}
