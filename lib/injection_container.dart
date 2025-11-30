import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/game/data/datasources/local_storage_datasource.dart';
import 'features/game/data/datasources/solar_system_remote_datasource.dart';
import 'features/game/data/repositories/game_repository_impl.dart';
import 'features/game/domain/repositories/game_repository.dart';
import 'features/game/domain/usecases/create_new_game.dart';
import 'features/game/domain/usecases/fetch_planet_names.dart';
import 'features/game/domain/usecases/load_game.dart';
import 'features/game/domain/usecases/save_game.dart';
import 'features/game/presentation/controllers/game_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Controllers
  sl.registerFactory(
    () => GameController(
      loadGame: sl(),
      saveGame: sl(),
      createNewGame: sl(),
      fetchPlanetNames: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoadGame(sl()));
  sl.registerLazySingleton(() => SaveGame(sl()));
  sl.registerLazySingleton(() => CreateNewGame(sl()));
  sl.registerLazySingleton(() => FetchPlanetNames(sl()));

  // Repository
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LocalStorageDataSource>(
    () => LocalStorageDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<SolarSystemRemoteDataSource>(
    () => SolarSystemRemoteDataSourceImpl(client: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
