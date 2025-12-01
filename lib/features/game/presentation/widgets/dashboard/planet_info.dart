import 'package:flutter/material.dart';

import '../../../../../core/utils/number_formatter.dart';

class PlanetInfo extends StatelessWidget {
  final dynamic planet;
  final int astrophysicsLevel;
  final bool canColonizeMore;

  const PlanetInfo({
    Key? key,
    required this.planet,
    required this.astrophysicsLevel,
    required this.canColonizeMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return planet.isColonized
        ? _ColonizedPlanetInfo(planet: planet)
        : _UncolonizedPlanetInfo(
            astrophysicsLevel: astrophysicsLevel,
            canColonizeMore: canColonizeMore,
          );
  }
}

// ============================================================================
// Info planète colonisée
// ============================================================================
class _ColonizedPlanetInfo extends StatelessWidget {
  final dynamic planet;

  const _ColonizedPlanetInfo({required this.planet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'M: ${NumberFormatter.format(planet.metal)} | '
          'C: ${NumberFormatter.format(planet.crystal)} | '
          'D: ${NumberFormatter.format(planet.deuterium)}',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        _buildProductionInfo(),
        _buildEnergyInfo(),
      ],
    );
  }

  Widget _buildProductionInfo() {
    final hasProduction =
        planet.metalProduction > 0 ||
        planet.crystalProduction > 0 ||
        planet.deuteriumProduction > 0;

    if (hasProduction) {
      return Text(
        'Prod: +${planet.metalProduction.toStringAsFixed(1)}/s M | '
        '+${planet.crystalProduction.toStringAsFixed(1)}/s C',
        style: const TextStyle(color: Colors.green, fontSize: 11),
      );
    } else {
      return const Text(
        'Aucune production (construisez des mines)',
        style: TextStyle(color: Colors.orange, fontSize: 11),
      );
    }
  }

  Widget _buildEnergyInfo() {
    return Row(
      children: [
        const Icon(Icons.bolt, size: 12, color: Colors.yellow),
        const SizedBox(width: 4),
        Text(
          '${planet.energyProduction.toInt()}/${planet.energyConsumption.toInt()}',
          style: TextStyle(
            color: planet.getAvailableEnergy() >= 0
                ? Colors.yellow
                : Colors.red,
            fontSize: 11,
          ),
        ),
        if (planet.getEnergyRatio() < 1.0) ...[
          const SizedBox(width: 8),
          Text(
            '(${(planet.getEnergyRatio() * 100).toInt()}% efficacité)',
            style: const TextStyle(color: Colors.orange, fontSize: 11),
          ),
        ],
      ],
    );
  }
}

// ============================================================================
// Info planète non colonisée
// ============================================================================
class _UncolonizedPlanetInfo extends StatelessWidget {
  final int astrophysicsLevel;
  final bool canColonizeMore;

  const _UncolonizedPlanetInfo({
    required this.astrophysicsLevel,
    required this.canColonizeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Non colonisée', style: TextStyle(color: Colors.grey)),
        if (astrophysicsLevel == 0)
          const Text(
            'Recherchez Astrophysique pour coloniser',
            style: TextStyle(color: Colors.orange, fontSize: 10),
          )
        else if (!canColonizeMore)
          const Text(
            'Améliorez Astrophysique pour plus de colonies',
            style: TextStyle(color: Colors.orange, fontSize: 10),
          ),
      ],
    );
  }
}
