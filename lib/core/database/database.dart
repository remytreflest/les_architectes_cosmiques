import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

//tables

import '../../features/building/domain/converters/building_type_converter.dart';
import '../../features/building/domain/entities/building.dart';
import '../../features/user/data/tables/user_table.dart';
import '../../features/building/data/tables/building_table.dart';
import '../../features/planet/data/tables/planet_table.dart';

//daos
import '../../features/planet/data/daos/planet_dao.dart';
import '../../features/planet/domain/converters/planet_name_converter.dart';
import '../../features/planet/domain/entities/planet_name.dart';
import '../../features/building/data/daos/building_dao.dart';
import '../../features/user/data/daos/user_dao.dart';
import '../../features/user/domain/converters/planet_id_converter.dart';

part 'database.g.dart';

@DriftDatabase(tables: [PlanetTable, BuildingTable, UserTable], daos: [PlanetDao, BuildingDao, UserDao])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}