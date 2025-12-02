import 'package:flutter/material.dart';

import '../../../../core/constants/game_definitions.dart';
import '../../domain/entities/planet.dart';
import '../widgets/cost_item.dart';

class BuildingsPage extends StatelessWidget {
  final Planet planet;
  final Function(String) onBuild;

  const BuildingsPage({Key? key, required this.planet, required this.onBuild})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Bâtiments',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...GameDefinitions.buildings.map((building) {
          final level = planet.buildings[building.id] ?? 0;
          final metalCost = building.getCost(level, 'metal');
          final crystalCost = building.getCost(level, 'crystal');
          final deuteriumCost = building.getCost(level, 'deuterium');

          final canBuild =
              planet.metal >= metalCost &&
              planet.crystal >= crystalCost &&
              planet.deuterium >= deuteriumCost;

          String energyInfo = '';
          if (building.id == 'solar_plant') {
            double currentProd = planet.calculateSolarPlantProduction(level);
            double nextProd = planet.calculateSolarPlantProduction(level + 1);
            energyInfo =
                'Production: ${currentProd.toInt()} → ${nextProd.toInt()} énergie';
          } else if (building.id == 'metal_mine') {
            int currentConsumption = 0;
            for (int i = 1; i <= level; i++) {
              currentConsumption += 10 * i;
            }
            int nextConsumption = 10 * (level + 1);
            energyInfo =
                'Consommation: $currentConsumption → ${currentConsumption + nextConsumption} énergie';
          } else if (building.id == 'crystal_mine') {
            int currentConsumption = 0;
            for (int i = 1; i <= level; i++) {
              currentConsumption += 10 * i;
            }
            int nextConsumption = 10 * (level + 1);
            energyInfo =
                'Consommation: $currentConsumption → ${currentConsumption + nextConsumption} énergie';
          } else if (building.id == 'deuterium_synthesizer') {
            int currentConsumption = 0;
            for (int i = 1; i <= level; i++) {
              currentConsumption += 20 * i;
            }
            int nextConsumption = 20 * (level + 1);
            energyInfo =
                'Consommation: $currentConsumption → ${currentConsumption + nextConsumption} énergie';
          }

          bool meetsRequirements = true;
          List<String> missingRequirements = [];
          for (String req in building.requirements) {
            if ((planet.buildings[req] ?? 0) == 0) {
              meetsRequirements = false;
              final reqBuilding = GameDefinitions.buildings.firstWhere(
                (b) => b.id == req,
              );
              missingRequirements.add(reqBuilding.name);
            }
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        building.id == 'solar_plant'
                            ? Icons.wb_sunny
                            : Icons.business,
                        color: building.id == 'solar_plant'
                            ? Colors.yellow
                            : Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              building.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Niveau $level',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(building.description),
                  if (building.requirements.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: meetsRequirements
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: meetsRequirements ? Colors.green : Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            meetsRequirements ? Icons.check_circle : Icons.lock,
                            size: 16,
                            color: meetsRequirements
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              meetsRequirements
                                  ? 'Prérequis validés'
                                  : 'Prérequis: ${missingRequirements.join(", ")}',
                              style: TextStyle(
                                fontSize: 12,
                                color: meetsRequirements
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (energyInfo.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: building.id == 'solar_plant'
                            ? Colors.yellow.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 16,
                            color: building.id == 'solar_plant'
                                ? Colors.yellow
                                : Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            energyInfo,
                            style: TextStyle(
                              fontSize: 12,
                              color: building.id == 'solar_plant'
                                  ? Colors.yellow
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    'Coût niveau ${level + 1}:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CostItem('M: $metalCost', planet.metal >= metalCost),
                      const SizedBox(width: 12),
                      CostItem(
                        'C: $crystalCost',
                        planet.crystal >= crystalCost,
                      ),
                      const SizedBox(width: 12),
                      CostItem(
                        'D: $deuteriumCost',
                        planet.deuterium >= deuteriumCost,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: canBuild && meetsRequirements
                        ? () {
                            planet.metal -= metalCost;
                            planet.crystal -= crystalCost;
                            planet.deuterium -= deuteriumCost;
                            onBuild(building.id);
                            planet.updateResources(globalTechnologies: {});
                          }
                        : null,
                    child: Text(
                      !meetsRequirements
                          ? 'Prérequis non remplis'
                          : canBuild
                          ? 'Construire'
                          : 'Ressources insuffisantes',
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
