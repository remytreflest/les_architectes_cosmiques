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
            // Nom de la planète
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
              style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // --- MODIFICATION ICI ---
            // Titre pour la section des ressources
            const Text(
              'Ressources :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),

            // Affiche la liste des ressources
            // On utilise une Column pour afficher chaque ressource sur une nouvelle ligne.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // planet.resources.map(...) transforme chaque objet 'Resource' en un widget 'Text'.
              // .toList() convertit le résultat en une liste de widgets.
              children: planet.resources.map((resource) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    // Affiche le nom et la quantité pour chaque ressource
                    '• ${resource.type} : ${resource.quantity}',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            // --- FIN DE LA MODIFICATION ---
          ],
        ),
      ),
    );
  }
}
