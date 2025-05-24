import 'package:app_notes/features/auth/domain/entities/user.dart';
import 'package:app_notes/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
