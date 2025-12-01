import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_data.dart';
import '../repositories/game_repository.dart';

class ColonizePlanet {
  final GameRepository repository;

  ColonizePlanet(this.repository);

  Future<Either<Failure, GameData>> call({
    required GameData gameData,
    required String planetId,
  }) async {
    try {
      // Vérifier que la technologie Astrophysique est recherchée
      final astrophysicsLevel = gameData.technologies['astrophysics'] ?? 0;

      if (astrophysicsLevel == 0) {
        return Left(
          const StorageFailure('Technologie Astrophysique non recherchée'),
        );
      }

      // Trouver la planète à coloniser
      final planet = gameData.planets.firstWhere(
        (p) => p.id == planetId,
        orElse: () => throw Exception('Planète introuvable'),
      );

      // Vérifier qu'elle n'est pas déjà colonisée
      if (planet.isColonized) {
        return Left(const StorageFailure('Planète déjà colonisée'));
      }

      // Calculer le nombre de planètes colonisées
      final colonizedCount = gameData.planets
          .where((p) => p.isColonized)
          .length;

      // Calculer le nombre maximum de planètes colonisables
      // Formule : 1 (planète mère) + niveau astrophysique
      final maxPlanets = 1 + astrophysicsLevel;

      if (colonizedCount >= maxPlanets) {
        return Left(
          StorageFailure(
            'Nombre maximum de planètes atteint ($maxPlanets). '
            'Améliorez la technologie Astrophysique.',
          ),
        );
      }

      // Obtenir la planète active pour le paiement
      final activePlanet = gameData.planets.firstWhere(
        (p) => p.id == gameData.activePlanetId,
      );

      // Coût de colonisation (augmente avec chaque planète)
      final colonizationCost = _calculateColonizationCost(colonizedCount);

      // Vérifier les ressources
      if (activePlanet.metal < colonizationCost['metal']! ||
          activePlanet.crystal < colonizationCost['crystal']! ||
          activePlanet.deuterium < colonizationCost['deuterium']!) {
        return Left(const StorageFailure('Ressources insuffisantes'));
      }

      // Déduire les ressources
      activePlanet.metal -= colonizationCost['metal']!;
      activePlanet.crystal -= colonizationCost['crystal']!;
      activePlanet.deuterium -= colonizationCost['deuterium']!;

      // Coloniser la planète
      planet.isColonized = true;
      planet.metal = 500; // Ressources de départ
      planet.crystal = 300;
      planet.deuterium = 100;

      // Sauvegarder
      await repository.saveGame(gameData);

      return Right(gameData);
    } catch (e) {
      return Left(StorageFailure('Erreur lors de la colonisation: $e'));
    }
  }

  /// Calcule le coût de colonisation selon le nombre de planètes déjà colonisées
  Map<String, int> _calculateColonizationCost(int colonizedCount) {
    // Formule exponentielle : coût de base × 2^(nombre de colonies - 1)
    final multiplier = (colonizedCount == 1) ? 1 : (1 << (colonizedCount - 1));

    return {
      'metal': 10000 * multiplier,
      'crystal': 5000 * multiplier,
      'deuterium': 2000 * multiplier,
    };
  }

  /// Calcule le coût pour une planète spécifique (pour affichage UI)
  static Map<String, int> getColonizationCost(GameData gameData) {
    final colonizedCount = gameData.planets.where((p) => p.isColonized).length;
    final multiplier = (colonizedCount == 1) ? 1 : (1 << (colonizedCount - 1));

    return {
      'metal': 10000 * multiplier,
      'crystal': 5000 * multiplier,
      'deuterium': 2000 * multiplier,
    };
  }
}
