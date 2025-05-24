import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_notes/core/utils/token_generator.dart';
import 'package:app_notes/features/auth/domain/entities/user.dart';
import 'package:app_notes/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_notes/features/auth/data/datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource localDatasource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.localDatasource, this.secureStorage);

  static const _tokenKey = 'auth_token';
  static const _emailKey = 'auth_email';

  @override
  Future<User?> login(String email, String password) async {
    if (kDebugMode) {
      print('[AuthRepository] Intentando login para email: $email');
    }

    final user = await localDatasource.getUserByCredentials(email, password);

    if (user != null) {
      final newToken = TokenGenerator.generateToken();

      if (kDebugMode) {
        print('[AuthRepository] Login exitoso para usuario: ${user.email}');
        print('[AuthRepository] Token generado: $newToken');
      }

      await secureStorage.write(key: _tokenKey, value: newToken);
      await secureStorage.write(key: _emailKey, value: email);

      if (kDebugMode) {
        print('[AuthRepository] Token y email guardados en storage');
      }

      return User(email: user.email, password: user.password, token: newToken);
    } else {
      if (kDebugMode) {
        print(
          '[AuthRepository] Login fallido: credenciales inválidas para email: $email',
        );
      }
    }

    return null;
  }

  @override
  Future<User?> checkSession() async {
    if (kDebugMode) {
      print('[AuthRepository] Iniciando validación de sesión...');
    }

    final email = await secureStorage.read(key: _emailKey);
    final token = await secureStorage.read(key: _tokenKey);

    if (kDebugMode) {
      print(
        '[AuthRepository] Datos leídos de storage -> Email: $email, Token: $token',
      );
    }

    if (email != null && token != null) {
      final user = await localDatasource.getUserByEmail(email);

      if (user != null) {
        if (kDebugMode) {
          print('[AuthRepository] Sesión válida para usuario: ${user.email}');
        }
        return User(email: user.email, password: user.password, token: token);
      } else {
        if (kDebugMode) {
          print(
            '[AuthRepository] No se encontró usuario con email: $email en la base local',
          );
        }
      }
    } else {
      if (kDebugMode) {
        print(
          '[AuthRepository] Sesión inválida o datos incompletos en storage',
        );
      }
    }

    return null;
  }

  @override
  Future<void> logout() async {
    if (kDebugMode) {
      print(
        '[AuthRepository] Cerrando sesión, eliminando token y email del storage',
      );
    }
    await secureStorage.delete(key: _tokenKey);
    await secureStorage.delete(key: _emailKey);
    if (kDebugMode) {
      print('[AuthRepository] Sesión cerrada correctamente');
    }
  }
}
