import 'package:drift/drift.dart';
import 'planet_table.dart';

class ResourceTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planetId => integer().references(PlanetTable, #id)(); // FK
  TextColumn get type => text()();
  RealColumn get quantity => real()();
}