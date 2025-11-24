import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../tables/planet_table.dart';

part 'planet_dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [PlanetTable])
class PlanetDao extends DatabaseAccessor<AppDatabase> with _$PlanetDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  PlanetDao(super.db);

  Future<int> insertPlanet(PlanetTableCompanion p){
    return into(planetTable).insert(p);
  }

  Future<List<PlanetTableData>> getPlanets() {
    return select(planetTable).get();
  }
}