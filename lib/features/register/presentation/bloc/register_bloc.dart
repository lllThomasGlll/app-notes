import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_notes/features/register/domain/entities/register_user.dart';
import 'package:app_notes/features/register/domain/usecases/register_user.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase registerUserUseCase;

  RegisterBloc(this.registerUserUseCase) : super(RegisterInitial()) {
    on<RegisterUserRequested>((event, emit) async {
      emit(RegisterLoading());
      final result = await registerUserUseCase(
        RegisterUser(email: event.email, password: event.password),
      );
      result
          ? emit(RegisterSuccess())
          : emit(
            RegisterFailure(
              "Error al registrar el usuario. Inténtalo de nuevo más tarde.",
            ),
          );
    });
  }
}
