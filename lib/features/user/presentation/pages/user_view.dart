// lib/features/user/presentation/pages/user_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:les_architectes_cosmiques/features/user/presentation/controller/user_controller.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    // Le UserController est déjà injecté. find() le récupère.
    final UserController controller = Get.find<UserController>();

    // Appeler loadUser seulement si l'utilisateur n'est pas déjà chargé
    // pour éviter des appels inutiles à chaque reconstruction.
    if (controller.currentUser.value == null && !controller.isLoading.value) {
      controller.loadUser();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Architecte'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.currentUser.value;

        if (user == null) {
          // --- MODIFICATION PRINCIPALE ICI ---
          // Affiche le formulaire de création si aucun utilisateur n'est trouvé.
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Créez votre profil Architecte',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Champ de texte pour le nom
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom de l\'Architecte',
                    border: OutlineInputBorder(),
                    hintText: 'Ex: Le Grand Bâtisseur',
                  ),
                  onSubmitted: (_) => controller
                      .createUser(), // Permet de valider avec la touche "Entrée"
                ),
                const SizedBox(height: 16),
                // Bouton pour créer l'utilisateur
                ElevatedButton(
                  onPressed: () {
                    // Appel de la méthode de création dans le contrôleur
                    controller.createUser();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Créer mon profil'),
                ),
              ],
            ),
          );
        }

        // --- AFFICHAGE DE L'UTILISATEUR (INCHANGÉ) ---
        // Si un user est présent, on l'affiche
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '👤 Nom : ${user.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '🌍 Planètes : ${user.planetIds?.join(", ") ?? "Aucune"}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }),
    );
  }
}
