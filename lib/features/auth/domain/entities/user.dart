import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String password;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.password,
    this.token = '',
  });

  @override
  List<Object?> get props => [id, email, password, token];
}
