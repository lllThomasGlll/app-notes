import 'package:flutter/material.dart';

import 'package:app_notes/features/register/presentation/screens/register_screen.dart';
import 'package:app_notes/features/notes/presentation/screens/notes_list_screen.dart';
import 'package:app_notes/features/auth/presentation/screens/splash_screen.dart';
import 'package:app_notes/features/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/notes':
        return MaterialPageRoute(builder: (_) => const NotesListScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('Ruta no encontrada: ${settings.name}'),
                ),
              ),
        );
    }
  }
}
