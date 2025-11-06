import 'package:les_architectes_cosmiques/shared/datas/planets.dart';

import '../../domain/entities/planet.dart';
import '../../domain/repositories/planet_repository.dart';

class InMemoryPlanetRepository implements PlanetRepository {
  List<Planet> _planets = [];

  InMemoryPlanetRepository() {
    // Création des ressources pour notre planète par défaut
    _planets = defaultPlanets;
  }

  @override
  Future<Planet?> getPlanet(int id) async {
    return _planets.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<Planet>> getPlanetsByUser(int userId) async {
    return _planets.where((p) => p.userId == userId).toList();
  }

  @override
  Future<void> addPlanet(Planet planet) async {
    _planets.add(planet);
  }

  @override
  Future<void> updatePlanet(Planet planet) async {
    final index = _planets.indexWhere((p) => p.id == planet.id);
    if (index != -1) {
      _planets[index] = planet;
    }
  }

  @override
  Future<void> deletePlanet(int id) async {
    _planets.removeWhere((p) => p.id == id);
  }
}
