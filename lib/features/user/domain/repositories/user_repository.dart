// lib/domain/repositories/user_repository.dart

import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  Future<void> addUser(User user);
  Future<void> deleteUser();
}
