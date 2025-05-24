import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:app_notes/core/database/database_helper.dart';
import 'package:app_notes/features/register/data/models/register_user_model.dart';

abstract class RegisterLocalDatasource {
  Future<bool> saveUser(RegisterUserModel user);
  Future<RegisterUserModel?> getUserByEmail(String email);
}

class RegisterLocalDatasourceImpl implements RegisterLocalDatasource {
  final DatabaseHelper databaseHelper;

  RegisterLocalDatasourceImpl(this.databaseHelper);

  @override
  Future<bool> saveUser(RegisterUserModel user) async {
    try {
      final db = await databaseHelper.database;

      final id = await db.insert(
        'usuarios',
        {'correo': user.email, 'contraseña': user.password},
        conflictAlgorithm: ConflictAlgorithm.abort, // evita duplicados
      );

      if (kDebugMode) {
        print('Usuario guardado con id: $id');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error al guardar usuario: $e');
      }
      return false;
    }
  }

  @override
  Future<RegisterUserModel?> getUserByEmail(String email) async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query(
        'usuarios',
        where: 'correo = ?',
        whereArgs: [email],
      );

      if (maps.isNotEmpty) {
        final map = maps.first;
        if (kDebugMode) {
          print('Usuario encontrado con correo: $email');
        }
        return RegisterUserModel(
          email: map['correo'] as String,
          password: map['contraseña'] as String,
        );
      } else {
        if (kDebugMode) {
          print('No existe usuario con correo: $email');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al consultar usuario por correo: $e');
      }
      return null;
    }
  }
}
