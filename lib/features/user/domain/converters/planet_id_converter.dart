// lib/core/database/converters/planet_id_converter.dart

import 'package:drift/drift.dart';

class PlanetIdConverter extends TypeConverter<List<int>?, String> {
  const PlanetIdConverter();

  @override
  List<int>? fromSql(String? fromDb) {
    if (fromDb == null || fromDb.isEmpty) {
      return null;
    }
    return fromDb.split(',').map(int.parse).toList();
  }

  @override
  // La valeur de retour est maintenant 'String' (non-nullable)
  String toSql(List<int>? value) {
    if (value == null || value.isEmpty) {
      // Retourne une chaîne vide au lieu de null
      return '';
    }
    return value.join(',');
  }
}
