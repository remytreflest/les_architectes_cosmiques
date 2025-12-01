import 'package:flutter/material.dart';

import '../../../../../core/utils/number_formatter.dart';
import '../../../domain/usecases/colonize_planet.dart';
import '../../controllers/game_controller.dart';

class ColonizeDialog extends StatelessWidget {
  final GameController controller;
  final String planetId;
  final String planetName;

  const ColonizeDialog({
    Key? key,
    required this.controller,
    required this.planetId,
    required this.planetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = controller.gameData!;
    final cost = ColonizePlanet.getColonizationCost(gameData);
    final activePlanet = gameData.planets.firstWhere(
      (p) => p.id == gameData.activePlanetId,
    );

    final canAfford =
        activePlanet.metal >= cost['metal']! &&
        activePlanet.crystal >= cost['crystal']! &&
        activePlanet.deuterium >= cost['deuterium']!;

    return AlertDialog(
      title: Text('Coloniser $planetName ?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coût de colonisation :',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _CostRow(
            'Métal',
            cost['metal']!,
            activePlanet.metal,
            Icons.currency_bitcoin,
            Colors.grey,
          ),
          _CostRow(
            'Cristal',
            cost['crystal']!,
            activePlanet.crystal,
            Icons.diamond,
            Colors.cyan,
          ),
          _CostRow(
            'Deutérium',
            cost['deuterium']!,
            activePlanet.deuterium,
            Icons.water_drop,
            Colors.green,
          ),
          if (!canAfford) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ressources insuffisantes',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Text(
            'Ressources de départ :',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 4),
          const Text(
            '• 500 Métal\n• 300 Cristal\n• 100 Deutérium',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, ''), // Annulé
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: canAfford
              ? () async {
                  final error = await controller.colonizePlanetById(planetId);
                  if (context.mounted) {
                    Navigator.pop(context, error); // Retourne l'erreur ou null
                  }
                }
              : null,
          child: const Text('Coloniser'),
        ),
      ],
    );
  }
}

class _CostRow extends StatelessWidget {
  final String resource;
  final int cost;
  final double available;
  final IconData icon;
  final Color color;

  const _CostRow(
    this.resource,
    this.cost,
    this.available,
    this.icon,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    final canAfford = available >= cost;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$resource: ${NumberFormatter.formatInt(cost)}',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            '(${NumberFormatter.format(available)})',
            style: TextStyle(
              fontSize: 12,
              color: canAfford ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
