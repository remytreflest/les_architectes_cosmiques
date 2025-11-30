import 'package:flutter/material.dart';

import '../../../../core/utils/number_formatter.dart';
import '../../domain/entities/planet.dart';

class ResourceBar extends StatelessWidget {
  final Planet planet;

  const ResourceBar({Key? key, required this.planet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableEnergy = planet.getAvailableEnergy();
    final energyRatio = planet.getEnergyRatio();

    return Container(
      color: const Color(0xFF1a237e),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ResourceItem(
                icon: Icons.currency_bitcoin,
                label: 'Métal',
                value: NumberFormatter.format(planet.metal),
                color: Colors.grey,
              ),
              _ResourceItem(
                icon: Icons.diamond,
                label: 'Cristal',
                value: NumberFormatter.format(planet.crystal),
                color: Colors.cyan,
              ),
              _ResourceItem(
                icon: Icons.water_drop,
                label: 'Deutérium',
                value: NumberFormatter.format(planet.deuterium),
                color: Colors.green,
              ),
              _EnergyItem(
                available: availableEnergy,
                production: planet.energyProduction,
                consumption: planet.energyConsumption,
                ratio: energyRatio,
              ),
            ],
          ),
          if (energyRatio < 1.0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: Colors.orange,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Production réduite à ${(energyRatio * 100).toInt()}% - Construisez des centrales',
                    style: const TextStyle(color: Colors.orange, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ResourceItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.white70)),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _EnergyItem extends StatelessWidget {
  final double available;
  final double production;
  final double consumption;
  final double ratio;

  const _EnergyItem({
    required this.available,
    required this.production,
    required this.consumption,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    final color = available >= 0 ? Colors.yellow : Colors.red;

    return Column(
      children: [
        Icon(Icons.bolt, color: color, size: 18),
        const SizedBox(height: 2),
        const Text(
          'Énergie',
          style: TextStyle(fontSize: 9, color: Colors.white70),
        ),
        Text(
          '${production.toInt()}/${consumption.toInt()}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
