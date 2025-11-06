import 'package:flutter/material.dart';

import '../../domain/entities/planet.dart';

class PlanetCard extends StatelessWidget {
  final Planet planet;

  const PlanetCard({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    final bool isColonized = planet.isColonized;

    return Card(
      color: isColonized ? null : Colors.grey.withOpacity(0.5),
      elevation: isColonized ? 3 : 1, // Moins d'ombre si non colonisée
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom de la planète (toujours visible)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  planet.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // Le texte est aussi grisé si non colonisé
                      color: isColonized ? null : Colors.white70),
                ),
                // --- FIN DE LA MODIFICATION ---
                if (isColonized)
                  const Icon(Icons.check_circle, color: Colors.green, size: 22)
                else
                  const Icon(Icons.radio_button_unchecked,
                      color: Colors.white70, size: 22),
              ],
            ),

            // --- AFFICHAGE CONDITIONNEL DES INFORMATIONS ---
            // Si la planète est colonisée, on affiche le reste des informations.
            if (isColonized)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  // Titre pour la section des ressources
                  const Text(
                    'Ressources :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  // Affiche la liste des ressources
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              )
            // Si la planète n'est pas colonisée, on n'affiche rien de plus.
            // Le `if` sans `else` est parfait pour cela.
            // --- FIN DE L'AFFICHAGE CONDITIONNEL ---
          ],
        ),
      ),
    );
  }
}
