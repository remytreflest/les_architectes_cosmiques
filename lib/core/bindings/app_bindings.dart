import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/core/database/database.dart';
import 'package:les_architectes_cosmiques/features/planet/data/daos/planet_dao.dart';
import 'package:les_architectes_cosmiques/features/planet/data/repositories_impl/planet_repository.dart';
import 'package:les_architectes_cosmiques/features/planet/domain/repositories/planet_repository.dart';
import 'package:les_architectes_cosmiques/features/planet/presentation/controller/planet_controller.dart';
import 'package:les_architectes_cosmiques/features/user/data/repositories_impl/in_memory_user_repository.dart';
import 'package:les_architectes_cosmiques/features/user/domain/repositories/user_repository.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/controller/user_controller.dart';


/// Le fichier de Bindings central pour toute l'application.
/// Il initialise toutes les dépendances (DAOs, Repositories, Controllers)
/// au démarrage de l'application.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // --- CORE ---

    // 1. Base de données
    // `permanent: true` garantit que l'instance ne sera jamais supprimée de la mémoire.
    Get.put<AppDatabase>(AppDatabase(), permanent: true);

    // --- FEATURES ---

    // ================= Planet Feature =================

    // 2. DAO (Data Access Object)
    // `Get.lazyPut` ne crée l'instance que la première fois qu'elle est demandée.
    Get.lazyPut<PlanetDao>(() => PlanetDao(Get.find<AppDatabase>()));

    // 3. Repository
    // Lie l'interface `PlanetRepository` à son implémentation `PlanetRepositoryImpl`.
    // L'injection de `PlanetDao` se fait automatiquement avec `Get.find()`.
    Get.lazyPut<PlanetRepository>(
          () => PlanetRepositoryImpl(planetDao: Get.find<PlanetDao>()),
    );

    // 4. Controller
    Get.lazyPut<PlanetController>(() => PlanetController(Get.find<PlanetRepository>()));


    // ================= User Feature =================

    // Repository
    Get.lazyPut<UserRepository>(() => InMemoryUserRepository());

    // Controller
    Get.lazyPut<UserController>(() => UserController(Get.find<UserRepository>()));
  }
}