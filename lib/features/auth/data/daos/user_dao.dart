import 'package:drift/drift.dart';
import '../../../../core/database/database.dart'; // Assurez-vous que ce chemin est correct
import '../tables/user_table.dart'; // Assurez-vous que le fichier de table s'appelle bien user_table.dart

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  // Le constructeur est nécessaire pour que la base de données principale puisse créer une instance de cet objet.
  UserDao(super.db);

  // Insérer un nouvel utilisateur
  Future<int> insertUser(UserTableCompanion user) {
    return into(users).insert(user, mode: InsertMode.insertOrReplace);
  }

  // Récupérer tous les utilisateurs
  Future<List<User>> getAllUsers() {
    return select(users).get();
  }

  // Récupérer un utilisateur par son ID
  Future<User?> getUserById(String id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  // Mettre à jour un utilisateur
  Future<bool> updateUser(UserTableCompanion user) {
    return update(users).replace(user);
  }

  // Supprimer un utilisateur
  Future<int> deleteUser(String id) {
    return (delete(users)..where((u) => u.id.equals(id))).go();
  }
}
