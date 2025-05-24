abstract class RegisterEvent {}

class RegisterUserRequested extends RegisterEvent {
  final String email;
  final String password;

  RegisterUserRequested(this.email, this.password);
}
