import 'package:drift/drift.dart';

import '../../../planet/data/tables/planet_table.dart';
import '../../domain/converters/building_type_converter.dart';

class BuildingTable extends Table {
  // Identifiant unique du bâtiment
  IntColumn get id => integer().autoIncrement()();

  // Type de bâtiment (mine, usine, etc.)
  TextColumn get type => text().map(const BuildingTypeConverter())();

  // Référence à la planète propriétaire
  // ⚠️ Tu avais `planetId` en String dans ton modèle, mais il est logique de le garder en int pour la clé étrangère
  IntColumn get planetId => integer().references(PlanetTable, #id)();

  // Niveau du bâtiment
  IntColumn get niveau => integer().withDefault(const Constant(1))();

  // Coût énergétique
  IntColumn get energieCost => integer()();
}