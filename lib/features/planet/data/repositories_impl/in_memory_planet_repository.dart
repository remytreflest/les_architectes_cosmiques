import 'package:les_architectes_cosmiques/features/planet/domain/entities/ressource.dart';

import '../../domain/entities/planet.dart';
import '../../domain/repositories/planet_repository.dart';

class InMemoryPlanetRepository implements PlanetRepository {
  final List<Planet> _planets = [];

  InMemoryPlanetRepository() {
    // Création des ressources pour notre planète par défaut
    final defaultResources = [
      const Resource(id: 1, planetId: 1, type: 'Métal', quantity: 1500.5),
      const Resource(id: 2, planetId: 1, type: 'Cristal', quantity: 870.0),
      const Resource(id: 3, planetId: 1, type: 'Deutérium', quantity: 5000.0),
    ];

    // Création de la planète par défaut avec ses ressources
    final defaultPlanet = Planet(
      id: 1,
      userId: 1, // En supposant qu'elle appartient à l'utilisateur par défaut
      name: 'Terra Nova',
      politicalRegime: 'Démocratie galactique',
      resources: defaultResources,
      isColonized: true,
    );

    // Ajout de la planète à notre liste en mémoire
    _planets.add(defaultPlanet);
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
