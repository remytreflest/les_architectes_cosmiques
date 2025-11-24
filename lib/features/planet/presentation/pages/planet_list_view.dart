import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/controller/user_controller.dart';

import '../controller/planet_controller.dart';
import '../widgets/planet_card.dart';

class PlanetsListView extends StatelessWidget {
  const PlanetsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlanetController planetController = Get.find<PlanetController>();
    final UserController userController = Get.find<UserController>();

    final currentUser = userController.currentUser.value;
    if (currentUser != null) {
      planetController.loadPlanetsForUser(currentUser.id);
      print('✅ Planètes chargées');
    }

    return Scaffold(
      body: Obx(() {
        if (planetController.planets.isEmpty) {
          return const Center(child: Text('Aucune planète !'));
        }
        return ListView.builder(
          itemCount: planetController.planets.length,
          itemBuilder: (context, index) =>
              PlanetCard(planet: planetController.planets[index]),
        );
      }),
    );
  }
}
