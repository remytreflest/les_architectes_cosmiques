import 'package:drift/drift.dart';
import '../../../../core/database/database.dart'; // Mettez à jour le chemin
import '../tables/user_table.dart'; // Mettez à jour le chemin

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  // --- Opérations CRUD ---

  // Insérer ou mettre à jour un utilisateur
  Future<int> upsertUser(UserTableCompanion user) {
    // Insère l'utilisateur. S'il existe déjà (même clé primaire), il est remplacé.
    return into(userTable).insert(user, mode: InsertMode.insertOrReplace);
  }

  // Récupérer un utilisateur par son ID
  Future<User?> getUserById(int id) {
    return (select(userTable)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  // Récupérer le premier utilisateur trouvé (utile s'il n'y en a qu'un)
  Future<User?> getFirstUser() {
    return select(userTable).getSingleOrNull();
  }

  // Mettre à jour un utilisateur
  Future<bool> updateUser(UserTableCompanion user) {
    return update(userTable).replace(user);
  }

  // Supprimer un utilisateur par son ID
  Future<int> deleteUser(int id) {
    return (delete(userTable)..where((u) => u.id.equals(id))).go();
  }

  // --- Opérations spécifiques ---

  // Surveiller les changements sur l'utilisateur (parfait pour l'UI réactive)
  Stream<User?> watchFirstUser() {
    return select(userTable).watchSingleOrNull();
  }
}
