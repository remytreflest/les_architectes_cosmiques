import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/controller/user_controller.dart';

import 'app.dart';
import 'features/user/data/repositories_impl/in_memory_user_repository.dart';

void main() {
  // Ici tu instancieras ton vrai UserRepository plus tard
  final userRepository = InMemoryUserRepository();
  Get.put(UserController(userRepository));

  runApp(const MyApp());
}
