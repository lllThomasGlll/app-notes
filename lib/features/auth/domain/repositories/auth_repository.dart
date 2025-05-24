import 'package:app_notes/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> checkSession();
  Future<void> logout();
}
