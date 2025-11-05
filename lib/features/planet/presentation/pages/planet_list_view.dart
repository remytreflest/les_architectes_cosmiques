import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/planet_controller.dart';
import '../widgets/planet_card.dart';

class PlanetsListView extends StatelessWidget {
  const PlanetsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanetController>();
    controller.loadPlanetsForUser(1);

    return Scaffold(
      appBar: AppBar(title: const Text('Liste des planètes')),
      body: Obx(() {
        if (controller.planets.isEmpty) {
          return const Center(child: Text('Aucune planète !'));
        }
        return ListView.builder(
          itemCount: controller.planets.length,
          itemBuilder: (context, index) =>
              PlanetCard(planet: controller.planets[index]),
        );
      }),
    );
  }
}
