import 'package:les_architectes_cosmiques/core/database/database.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/entities/planet.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/entities/planet_name.dart';

import '../../domain/repositories/planet_repository.dart';
import '../daos/planet_dao.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  final PlanetDao planetDao;

  PlanetRepositoryImpl({required this.planetDao});

  @override
  Future<void> addPlanet(Planet planet) async {
    PlanetTableCompanion pt = PlanetTableCompanion.insert(name: PlanetName.terre, userId: 25);
    planetDao.insertPlanet(pt);
    //afficher le nom de la premiere planete
    List<PlanetTableData> ps = await planetDao.getPlanets();
    print("✅");
    for(PlanetTableData p in ps){
      print(p.toString());

    }
  }

  @override
  Future<void> deletePlanet(int id) {
    // TODO: implement deletePlanet
    throw UnimplementedError();
  }

  @override
  Future<Planet?> getPlanet(int id) {
    // TODO: implement getPlanet
    throw UnimplementedError();
  }

  @override
  Future<List<Planet>> getPlanetsByUser(int userId) {
    // TODO: implement getPlanetsByUser
    throw UnimplementedError();
  }

  @override
  Future<void> updatePlanet(Planet planet) {
    // TODO: implement updatePlanet
    throw UnimplementedError();
  }
}