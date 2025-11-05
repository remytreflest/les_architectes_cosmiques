import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/planet/data/repositories_impl/in_memory_planet_repository.dart';
import 'package:les_architectes_cosmiques/features/planet/presentation/controller/planet_controller.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/controller/user_controller.dart';

import 'app.dart';
import 'features/user/data/repositories_impl/in_memory_user_repository.dart';

void main() {
  final userRepository = InMemoryUserRepository();
  Get.put(UserController(userRepository));

  final planetRepository = InMemoryPlanetRepository();
  Get.put(PlanetController(planetRepository));

  runApp(const MyApp());
}
