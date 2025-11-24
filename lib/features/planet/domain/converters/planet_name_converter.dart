import 'package:drift/drift.dart';
import '../entities/planet_name.dart';

class PlanetNameConverter extends TypeConverter<PlanetName, String> {
  const PlanetNameConverter();

  @override
  PlanetName fromSql(String fromDb) {
    return PlanetName.values.firstWhere(
          (e) => e.name == fromDb,
      orElse: () => PlanetName.terre, // valeur par défaut
    );
  }

  @override
  String toSql(PlanetName value) => value.name;
}