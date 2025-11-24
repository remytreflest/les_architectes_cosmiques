import 'package:drift/drift.dart';
import '../../../../core/database/database.dart'; // Assurez-vous que le chemin est correct
import '../tables/building_table.dart';
import '../../../planet/data/tables/planet_table.dart'; // Requis pour les requêtes jointes

// Importez votre classe de données si elle est dans un autre fichier
// import '../../domain/entities/building.dart';

part 'building_dao.g.dart';

@DriftAccessor(tables: [BuildingTable, PlanetTable])
class BuildingDao extends DatabaseAccessor<AppDatabase> with _$BuildingDaoMixin {
  // Constructeur standard pour un DAO Drift
  BuildingDao(super.db);

  // --- Opérations CRUD de base ---

  // Insérer un nouveau bâtiment
  Future<int> insertBuilding(BuildingTableCompanion building) {
    return into(buildingTable).insert(building);
  }

  // Récupérer un bâtiment par son ID
  Future<BuildingTableData?> getBuildingById(int id) {
    return (select(buildingTable)..where((b) => b.id.equals(id))).getSingleOrNull();
  }

  // Mettre à jour un bâtiment (par exemple, pour augmenter son niveau)
  Future<bool> updateBuilding(BuildingTableCompanion building) {
    // 'replace' met à jour toute l'entité en se basant sur sa clé primaire
    return update(buildingTable).replace(building);
  }

  // Supprimer un bâtiment par son ID
  Future<int> deleteBuilding(int id) {
    return (delete(buildingTable)..where((b) => b.id.equals(id))).go();
  }

  // --- Opérations spécifiques ---

  // Récupérer tous les bâtiments d'une planète spécifique
  Future<List<BuildingTableData>> getAllBuildingsForPlanet(int planetId) {
    return (select(buildingTable)..where((b) => b.planetId.equals(planetId))).get();
  }

  // Surveiller les changements sur les bâtiments d'une planète (utile pour l'UI)
  Stream<List<BuildingTableData>> watchAllBuildingsForPlanet(int planetId) {
    return (select(buildingTable)..where((b) => b.planetId.equals(planetId))).watch();
  }
}
