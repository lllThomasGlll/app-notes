import 'package:flutter/foundation.dart';

import 'package:app_notes/features/register/domain/entities/register_user.dart';
import 'package:app_notes/features/register/data/models/register_user_model.dart';
import 'package:app_notes/features/register/domain/repositories/register_repository.dart';
import 'package:app_notes/features/register/data/datasources/register_local_datasource.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterLocalDatasource datasource;

  RegisterRepositoryImpl(this.datasource);

  @override
  Future<bool> registerUser(RegisterUser user) async {
    if (kDebugMode) {
      print(
        '[RegisterRepository] Intentando registrar usuario con email: ${user.email}',
      );
    }

    final existingUser = await datasource.getUserByEmail(user.email);
    if (existingUser != null) {
      if (kDebugMode) {
        print(
          '[RegisterRepository] Registro fallido: el email ${user.email} ya está registrado',
        );
      }
      return false;
    }

    final model = RegisterUserModel(email: user.email, password: user.password);
    final result = await datasource.saveUser(model);

    if (kDebugMode) {
      if (result) {
        print(
          '[RegisterRepository] Registro exitoso para el email: ${user.email}',
        );
      } else {
        print('[RegisterRepository] Falló al guardar el usuario en datasource');
      }
    }

    return result;
  }
}
