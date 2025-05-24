import 'package:app_notes/features/auth/domain/entities/user.dart';
import 'package:app_notes/features/auth/domain/repositories/auth_repository.dart';

class CheckSession {
  final AuthRepository repository;

  CheckSession(this.repository);

  Future<User?> call() => repository.checkSession();
}
