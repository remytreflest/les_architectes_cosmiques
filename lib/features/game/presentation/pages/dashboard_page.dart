import 'package:flutter/material.dart';

import '../controllers/game_controller.dart';

class DashboardPage extends StatelessWidget {
  final GameController controller;
  final Function(String) onPlanetChange;

  const DashboardPage({
    Key? key,
    required this.controller,
    required this.onPlanetChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = controller.gameData!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Système Solaire',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Sélectionnez votre planète active',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ...gameData.planets.map((planet) {
          final isActive = planet.id == gameData.activePlanetId;
          final isColonized = planet.isColonized;

          return Card(
            color: isActive && isColonized
                ? Colors.blue.withOpacity(0.2)
                : isColonized
                ? null
                : Colors.grey.withOpacity(0.1),
            child: ListTile(
              leading: Icon(
                Icons.public,
                size: 40,
                color: isColonized ? Colors.blue : Colors.grey,
              ),
              title: Text(
                planet.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isColonized ? Colors.white : Colors.grey,
                ),
              ),
              subtitle: isColonized
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'M: ${planet.metal.toInt()} | C: ${planet.crystal.toInt()} | D: ${planet.deuterium.toInt()}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        if (planet.metalProduction > 0 ||
                            planet.crystalProduction > 0 ||
                            planet.deuteriumProduction > 0)
                          Text(
                            'Prod: +${planet.metalProduction.toStringAsFixed(1)}/s M | +${planet.crystalProduction.toStringAsFixed(1)}/s C',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 11,
                            ),
                          )
                        else
                          const Text(
                            'Aucune production (construisez des mines)',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 11,
                            ),
                          ),
                        Row(
                          children: [
                            const Icon(
                              Icons.bolt,
                              size: 12,
                              color: Colors.yellow,
                            ),
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
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    )
                  : const Text(
                      'Non colonisée',
                      style: TextStyle(color: Colors.grey),
                    ),
              trailing: isActive && isColonized
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : isColonized
                  ? const Icon(Icons.arrow_forward_ios, color: Colors.white54)
                  : const Icon(Icons.lock, color: Colors.grey),
              onTap: isColonized ? () => onPlanetChange(planet.id) : null,
            ),
          );
        }),
        const SizedBox(height: 20),
        if (gameData.planets.where((p) => !p.isColonized).isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 10),
          Card(
            color: Colors.orange.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 32,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Planètes à coloniser',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Développez la technologie Astrophysique pour coloniser de nouvelles planètes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
