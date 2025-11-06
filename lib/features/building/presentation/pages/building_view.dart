import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/planet/presentation/controller/planet_controller.dart';

class BuildingView extends StatelessWidget {
  final String planetId;
  const BuildingView({Key? key, required this.planetId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlanetController planetController = Get.find<PlanetController>();

    return Obx(() {
      // On récupère la bonne planète selon son id
      final planet = planetController.planets.firstWhere(
        (p) => p.id.toString() == planetId,
        orElse: () => planetController.currentPlanet.value,
      );
      final buildings = planet.buildings;

      return ListView.builder(
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          final b = buildings[index];
          return Card(
            child: ListTile(
              title: Text('${b.type.name} (Niveau ${b.niveau})'),
              subtitle: b.isProductionBuilding
                  ? Text('Production: ${b.productionRate} /h')
                  : Text('Non-productif'),
              trailing: IconButton(
                icon: Icon(Icons.upgrade),
                onPressed: () => planetController.upgradeBuilding(b.type),
              ),
            ),
          );
        },
      );
    });
  }
}
