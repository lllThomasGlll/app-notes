import 'package:app_notes/features/register/domain/entities/register_user.dart';

abstract class RegisterRepository {
  Future<bool> registerUser(RegisterUser user);
}
