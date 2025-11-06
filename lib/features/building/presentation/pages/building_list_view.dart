import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/building/domain/entities/building.dart';
import 'package:les_architectes_cosmiques/features/planet/presentation/controller/planet_controller.dart';
import 'package:les_architectes_cosmiques/shared/widgets/custom_bottom_nav_bar.dart'; // Assure-toi que ce chemin est correct

class BuildingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planetController = Get.find<PlanetController>();

    return Obx(() {
      final planet = planetController.currentPlanet.value;

      // Batiments déjà construits (niveau > 0)
      final builtBuildings =
          planet.buildings.where((b) => b.niveau > 0).toList();

      // Batiments ENCORE NON construits mais potentiellement possible (niveau == 0 ET déblocable)
      final availableBuildings = planet.buildings
          .where((b) =>
              b.niveau == 0 && planetController.isBuildingUnlocked(b.type))
          .toList();

      // Batiments inaccessibles (non construits et non déblocables)
      final lockedBuildings = planet.buildings
          .where((b) =>
              b.niveau == 0 && !planetController.isBuildingUnlocked(b.type))
          .toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Bâtiments de ${planet.name}'),
        ),
        body: ListView(
          padding:
              const EdgeInsets.only(bottom: 72), // espace pour la bottom bar
          children: [
            if (builtBuildings.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Text(
                  'Bâtiments construits',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ...builtBuildings.map((building) => _BuildingCard(
                  building: building,
                  planetController: planetController,
                  color: Theme.of(context).colorScheme.surface,
                  enabled: true,
                )),
            if (availableBuildings.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Text(
                  'Bâtiments disponibles à la construction',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ...availableBuildings.map((building) => _BuildingCard(
                  building: building,
                  planetController: planetController,
                  color: Colors.blue.shade50,
                  enabled: true,
                )),
            if (lockedBuildings.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Text(
                  'Bâtiments indisponibles',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey),
                ),
              ),
            ...lockedBuildings.map((building) => _BuildingCard(
                  building: building,
                  planetController: planetController,
                  color: Colors.grey.shade200,
                  enabled: false,
                )),
            const SizedBox(height: 80), // pour ne pas masquer la dernière carte
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      );
    });
  }
}

class _BuildingCard extends StatelessWidget {
  final Building building;
  final PlanetController planetController;
  final Color color;
  final bool enabled;

  const _BuildingCard({
    required this.building,
    required this.planetController,
    required this.color,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = buildingTypesData[building.type]!;

    return Card(
      elevation: 3,
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(Icons.apartment, color: enabled ? null : Colors.grey),
        title: Text(
          '${data.label} (Niveau ${building.niveau})',
          style: TextStyle(
            color:
                enabled ? Theme.of(context).colorScheme.onSurface : Colors.grey,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.isProduction
                  ? 'Production: ${building.productionRate} /h'
                  : 'Non-productif',
              style: TextStyle(
                color: enabled ? null : Colors.grey,
              ),
            ),
            if (building.requirements.isNotEmpty)
              Text(
                'Prérequis : ' +
                    building.requirements.entries
                        .map((e) =>
                            '${buildingTypesData[e.key]!.label} niveau ${e.value}')
                        .join(', '),
                style: TextStyle(
                  fontSize: 12,
                  color: enabled ? Colors.grey[700] : Colors.grey[500],
                ),
              ),
            Text('Coût énergie : ${building.energieCost}',
                style: TextStyle(
                  color: enabled ? null : Colors.grey,
                )),
          ],
        ),
        trailing: enabled
            ? IconButton(
                icon: const Icon(Icons.upgrade),
                onPressed: () =>
                    planetController.upgradeBuilding(building.type),
                color: Theme.of(context).colorScheme.primary,
                tooltip: 'Améliorer',
              )
            : Icon(Icons.lock_outline, color: Colors.grey),
      ),
    );
  }
}
