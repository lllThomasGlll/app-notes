import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_notes/features/auth/domain/usecases/check_session.dart';
import 'package:app_notes/features/auth/presentation/bloc/auth_event.dart';
import 'package:app_notes/features/auth/domain/usecases/logout_user.dart';
import 'package:app_notes/features/auth/domain/usecases/login_user.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final CheckSession checkSession;

  AuthBloc({
    required this.loginUser,
    required this.logoutUser,
    required this.checkSession,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<CheckSessionRequested>(_onCheckSession);
    on<LogoutRequested>(_onLogout);
  }

  void _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await loginUser(event.email, event.password);
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(const AuthError('Usuario o contraseña incorrecta.'));
    }
  }

  void _onCheckSession(
    CheckSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = await checkSession();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await logoutUser();
    emit(Unauthenticated());
  }
}
