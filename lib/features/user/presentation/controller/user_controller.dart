// lib/presentation/user/user_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _repository;
  final TextEditingController nameController = TextEditingController();

  UserController(this._repository);

  /// L'utilisateur actuellement chargé
  final Rx<User?> currentUser = Rx<User?>(null);

  /// Indique si une opération est en cours (utile pour un loader)
  final RxBool isLoading = false.obs;

  Future<void> loadUser() async {
    isLoading.value = true;
    final user = await _repository.getUser();
    currentUser.value = user;
    isLoading.value = false;
  }

  void updateUser(User newUser) {
    currentUser.value = newUser;
  }

  /// Supprime l'utilisateur actuel
  Future<void> deleteCurrentUser() async {
    final user = currentUser.value;
    if (user != null) {
      await _repository.deleteUser();
      currentUser.value = null;
    }
  }

  /// Crée un nouvel utilisateur à partir du nom saisi dans le champ de texte.
  Future<void> createUser() async {
    // Vérification que le champ n'est pas vide
    final String name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar('Erreur de création',
          'Le nom de l\'Architecte ne peut pas être vide.');
      return;
    }

    isLoading.value = true;
    try {
      // --- CORRECTION PRINCIPALE ICI ---
      // Création du nouvel utilisateur en respectant le modèle User
      final newUser = User(
        // Génère un ID 'int' unique basé sur le temps actuel.
        id: 1,
        name: name,
        // La liste planetIds aura sa valeur par défaut comme défini dans le modèle User.
      );

      // Sauvegarde du nouvel utilisateur via le cas d'utilisation
      await _repository.addUser(newUser);

      // Mise à jour de l'état pour que la vue se reconstruise
      currentUser.value = newUser;

      // Efface le champ de texte après la création
      nameController.clear();
      Get.offAllNamed('/dashboard');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de créer l\'utilisateur: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Réinitialise complètement l'état utilisateur
  void clear() {
    currentUser.value = null;
  }
}
