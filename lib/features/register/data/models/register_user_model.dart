import 'package:app_notes/features/register/domain/entities/register_user.dart';

class RegisterUserModel extends RegisterUser {
  const RegisterUserModel({required super.email, required super.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(email: json['email'], password: json['password']);
  }
}
