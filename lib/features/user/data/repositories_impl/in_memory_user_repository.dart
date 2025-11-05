// lib/features/user/data/repositories_impl/in_memory_user_repository.dart

import 'dart:async'; // Importé pour utiliser Completer

import 'package:les_architectes_cosmiques/features/user/domain/repositories/user_repository.dart';

import '../../domain/entities/user.dart';

// Correction du chemin d'importation pour suivre une structure logique
// Si 'user' et 'auth' sont des features séparées, l'entité User devrait probablement
// se trouver dans la feature 'user' ou une feature 'shared'/'core'.
// Je conserve votre import original pour l'instant.

/// Un dépôt en mémoire pour gérer l'entité [User].
///
/// Idéal pour les tests, le prototypage ou le développement en mode déconnecté.
/// Il simule le comportement asynchrone d'un vrai dépôt (ex: appel réseau).
class InMemoryUserRepository implements UserRepository {
  User? _currentUser;

  /// Récupère l'utilisateur actuellement stocké en mémoire.
  ///
  /// Retourne un [Future] qui se complète avec l'utilisateur [User] s'il existe,
  /// ou avec `null` dans le cas contraire.
  /// Un délai artificiel est ajouté pour simuler la latence du réseau.
  @override
  Future<User?> getUser() async {
    return _currentUser;
  }

  /// Sauvegarde ou met à jour l'utilisateur en mémoire.
  ///
  /// Le nom `saveUser` est plus clair que `addUser` car il implique une
  /// opération de sauvegarde/remplacement plutôt qu'un ajout à une liste.
  @override
  Future<void> addUser(User user) async {
    _currentUser = user;
    // Dans une vraie implémentation, on pourrait retourner un booléen
    // pour indiquer si la sauvegarde a réussi.
  }

  /// Supprime l'utilisateur actuellement stocké en mémoire.
  @override
  Future<void> deleteUser() async {
    _currentUser = null;
  }
}
