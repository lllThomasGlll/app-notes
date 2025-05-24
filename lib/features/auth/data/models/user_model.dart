import 'package:app_notes/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.email,
    required super.password,
    String? token,
  }) : super(token: token ?? '');

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(email: map['correo'], password: map['contraseña']);
  }

  Map<String, dynamic> toMap() {
    return {'correo': email, 'contraseña': password};
  }
}
