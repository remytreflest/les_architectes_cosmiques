import 'package:drift/drift.dart';
// Assurez-vous que le chemin d'importation est correct
import '../../domain/converters/planet_id_converter.dart';

@DataClassName('User')
class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  // La ligne à corriger est ci-dessous
  TextColumn get planetIds => text()
  // Enveloppez votre convertisseur avec NullAwareTypeConverter.wrap()
      .map(NullAwareTypeConverter.wrap(const PlanetIdConverter()))
      .nullable()(); // Vous pouvez toujours garder .nullable() ici
}
