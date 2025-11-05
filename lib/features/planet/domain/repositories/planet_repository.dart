import '../entities/planet.dart';

abstract class PlanetRepository {
  Future<Planet?> getPlanet(int id);
  Future<List<Planet>> getPlanetsByUser(int userId);
  Future<void> addPlanet(Planet planet);
  Future<void> updatePlanet(Planet planet);
  Future<void> deletePlanet(int id);
}
