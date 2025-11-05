import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/entities/ressource.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/repositories/planet_repository.dart';

import '../../domain/entities/planet.dart';

class PlanetController extends GetxController {
  final PlanetRepository repository;
  PlanetController(this.repository);

  final RxList<Planet> planets = <Planet>[].obs;

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
