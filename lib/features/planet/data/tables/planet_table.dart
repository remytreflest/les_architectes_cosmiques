import 'package:drift/drift.dart';
import '../../domain/converters/planet_name_converter.dart';

class PlanetTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()(); // Lien avec l'utilisateur

  // PlanetName → texte avec converter
  TextColumn get name => text().map(const PlanetNameConverter())();

  // Optionnel
  TextColumn get politicalRegime => text().nullable()();

  // Colonisée ou non
  BoolColumn get isColonized => boolean().withDefault(const Constant(false))();
}