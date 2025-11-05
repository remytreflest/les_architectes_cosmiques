import 'package:flutter/material.dart';

import '../../domain/entities/planet.dart';

class PlanetCard extends StatelessWidget {
  final Planet planet;

  const PlanetCard({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  planet.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (planet.isColonized)
                  const Icon(Icons.check_circle, color: Colors.green, size: 22)
                else
                  const Icon(Icons.radio_button_unchecked,
                      color: Colors.redAccent, size: 22),
              ],
            ),
            const SizedBox(height: 8),

            // Régime politique
            Text(
              'Régime : ${planet.politicalRegime ?? "Aucun"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Nombre de ressources
            Text(
              'Ressources : ${planet.resources.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
