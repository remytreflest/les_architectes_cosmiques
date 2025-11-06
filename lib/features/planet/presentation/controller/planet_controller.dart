import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/building/domain/entities/building.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/entities/ressource.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/repositories/planet_repository.dart';
import 'package:les_architectes_cosmiques/shared/datas/planets.dart';

import '../../domain/entities/planet.dart';

class PlanetController extends GetxController {
  final PlanetRepository repository;
  final RxList<Planet> planets = <Planet>[].obs;
  Rx<Planet> currentPlanet = Rx<Planet>(defaultPlanets[2]);

  PlanetController(this.repository);

  bool isBuildingUnlocked(BuildingType type) {
    final currentLevels = {
      for (final b in currentPlanet.value!.buildings) b.type: b.niveau
    };
    final requirements = buildingTypesData[type]?.requirements ?? {};
    for (final entry in requirements.entries) {
      if ((currentLevels[entry.key] ?? 0) < entry.value) return false;
    }
    return true;
  }

  void setCurrentPlanet(Planet planet) {
    currentPlanet.value = planet;
  }

  // Méthode pour effectuer les modifications métier nécessaires
  void upgradeBuilding(BuildingType type) {
    final b = currentPlanet.value!.buildings.firstWhere((b) => b.type == type);
    b.niveau += 1;
    currentPlanet.refresh();
  }

  Future<void> loadPlanetsForUser(int userId) async {
    planets.value = await repository.getPlanetsByUser(userId);
    print('✅ Planètes chargées');
    print('✅ Planètes chargées : ${planets.value}');
  }

  Future<void> addResourceToPlanet(int planetId, Resource resource) async {
    final planetIndex = planets.indexWhere((p) => p.id == planetId);
    if (planetIndex != -1) {
      final planet = planets[planetIndex];
      final updated =
          planet.copyWith(resources: [...planet.resources, resource]);
      await repository.updatePlanet(updated);
      planets[planetIndex] = updated;
    }
  }

  Future<void> removeResourceFromPlanet(int planetId, int resourceId) async {
    final planetIndex = planets.indexWhere((p) => p.id == planetId);
    if (planetIndex != -1) {
      final planet = planets[planetIndex];
      final updated = planet.copyWith(
          resources:
              planet.resources.where((r) => r.id != resourceId).toList());
      await repository.updatePlanet(updated);
      planets[planetIndex] = updated;
    }
  }
}
