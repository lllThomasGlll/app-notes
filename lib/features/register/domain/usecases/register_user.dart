import 'package:app_notes/features/register/domain/entities/register_user.dart';
import 'package:app_notes/features/register/domain/repositories/register_repository.dart';

class RegisterUserUseCase {
  final RegisterRepository repository;

  RegisterUserUseCase(this.repository);

  Future<bool> call(RegisterUser user) => repository.registerUser(user);
}
