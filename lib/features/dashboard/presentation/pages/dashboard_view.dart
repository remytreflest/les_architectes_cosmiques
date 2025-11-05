import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/planet/presentation/controller/planet_controller.dart';
import 'package:les_architectes_cosmiques/features/planet/presentation/pages/planet_list_view.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/controller/user_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final planetController = Get.find<PlanetController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Obx(() {
        final user = userController.currentUser.value;
        final planets = planetController.planets
            .where((p) => p.userId == user?.id)
            .toList();

        if (user == null) {
          return const Center(child: Text('Aucun utilisateur connecté'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('👤 Utilisateur : ${user.name}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Expanded(
                child: PlanetsListView(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
