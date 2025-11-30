import 'package:les_architectes_cosmiques/features/game/domain/entities/planet.dart';

class GameData {
  final String playerName;
  final List<Planet> planets;
  String activePlanetId;
  Map<String, int> technologies;
  Map<String, int> diplomacyTechs;

  GameData({
    required this.playerName,
    required this.planets,
    required this.activePlanetId,
    Map<String, int>? technologies,
    Map<String, int>? diplomacyTechs,
  }) : technologies = technologies ?? {},
       diplomacyTechs = diplomacyTechs ?? {};
}
