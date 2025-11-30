import 'package:flutter/material.dart';

import '../../../../core/constants/game_definitions.dart';
import '../../domain/entities/game_data.dart';
import '../../domain/entities/planet.dart';
import '../widgets/cost_item.dart';

class TechnologiesPage extends StatelessWidget {
  final GameData gameData;
  final Planet planet;
  final bool isDiplomacy;
  final Function(String) onResearch;

  const TechnologiesPage({
    Key? key,
    required this.gameData,
    required this.planet,
    required this.isDiplomacy,
    required this.onResearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final techs = isDiplomacy
        ? GameDefinitions.diplomacyTechs
        : GameDefinitions.technologies;
    final techLevels = isDiplomacy
        ? gameData.diplomacyTechs
        : gameData.technologies;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          isDiplomacy ? '🎭 Politiques Galactiques' : 'Technologies',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        if (isDiplomacy) ...[
          const SizedBox(height: 8),
          const Text(
            'Adoptez des politiques spatiales pour des bonus permanents !',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
        const SizedBox(height: 20),
        ...techs.map((tech) {
          final level = techLevels[tech.id] ?? 0;
          final metalCost = tech.getCost(level, 'metal');
          final crystalCost = tech.getCost(level, 'crystal');
          final deuteriumCost = tech.getCost(level, 'deuterium');

          final canResearch =
              planet.metal >= metalCost &&
              planet.crystal >= crystalCost &&
              planet.deuterium >= deuteriumCost;

          bool meetsRequirements = true;
          List<String> missingRequirements = [];
          for (String req in tech.requirements) {
            final allTechs = [
              ...GameDefinitions.technologies,
              ...GameDefinitions.diplomacyTechs,
            ];
            final hasInNormal = (gameData.technologies[req] ?? 0) > 0;
            final hasInDiplomacy = (gameData.diplomacyTechs[req] ?? 0) > 0;

            if (!hasInNormal && !hasInDiplomacy) {
              meetsRequirements = false;
              final reqTech = allTechs.firstWhere((t) => t.id == req);
              missingRequirements.add(reqTech.name);
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
                        isDiplomacy ? Icons.emoji_events : Icons.science,
                        color: isDiplomacy ? Colors.amber : Colors.purple,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tech.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              isDiplomacy
                                  ? (level > 0 ? '✅ Activé' : 'Non adopté')
                                  : 'Niveau $level',
                              style: TextStyle(
                                color: level > 0 ? Colors.green : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tech.description,
                    style: TextStyle(
                      color: isDiplomacy ? Colors.amber[200] : Colors.white,
                    ),
                  ),
                  if (tech.requirements.isNotEmpty) ...[
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
                  const SizedBox(height: 12),
                  Text(
                    isDiplomacy && level > 0
                        ? 'Déjà adopté'
                        : 'Coût ${isDiplomacy ? "" : "niveau ${level + 1}"}:',
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
                    onPressed:
                        (canResearch &&
                            meetsRequirements &&
                            !(isDiplomacy && level > 0))
                        ? () {
                            planet.metal -= metalCost;
                            planet.crystal -= crystalCost;
                            planet.deuterium -= deuteriumCost;
                            onResearch(tech.id);
                          }
                        : null,
                    child: Text(
                      isDiplomacy && level > 0
                          ? '✅ Politique active'
                          : !meetsRequirements
                          ? 'Prérequis non remplis'
                          : canResearch
                          ? (isDiplomacy ? 'Adopter' : 'Rechercher')
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
