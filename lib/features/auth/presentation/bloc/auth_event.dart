import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CheckSessionRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogoutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}


