import 'package:app_notes/core/database/database_helper.dart';
import 'package:app_notes/features/auth/data/models/user_model.dart';

abstract class AuthLocalDatasource {
  Future<UserModel?> getUserByCredentials(String email, String password);
  Future<UserModel?> getUserByEmail(String email);
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final DatabaseHelper databaseHelper;

  AuthLocalDatasourceImpl(this.databaseHelper);

  static const _table = 'usuarios';

  @override
  Future<UserModel?> getUserByCredentials(String email, String password) async {
    final db = await databaseHelper.database;
    final result = await db.query(
      _table,
      where: 'correo = ? AND contraseña = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await databaseHelper.database;
    final result = await db.query(
      _table,
      where: 'correo = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }
}
