import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_notes/features/auth/injection/auth_injection.dart';
import 'package:app_notes/features/auth/presentation/bloc/barrel_auth_bloc.dart';
import 'package:app_notes/features/auth/domain/repositories/auth_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  void _logout() async {
    await sl<AuthRepository>().logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Icon(FontAwesomeIcons.userGear, size: 50, color: Colors.amber[700]),
          const SizedBox(height: 20),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidUser,
                    color: Colors.amber[700],
                  ),
                  title: const Text("Usuario"),
                  subtitle: Text(state.user.email),
                );
              } else {
                return const ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.grey),
                  title: Text("Usuario"),
                  subtitle: Text("Cargando..."),
                );
              }
            },
          ),

          const Divider(),

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return ListTile(
                  leading: Icon(
                    FontAwesomeIcons.squareDribbble,
                    color: Colors.amber[700],
                  ),
                  title: const Text("Token"),
                  subtitle: Text(state.user.token),
                );
              } else {
                return const ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.grey),
                  title: Text("Token"),
                  subtitle: Text("Cargando..."),
                );
              }
            },
          ),

          const Divider(),

          ListTile(
            leading: Icon(
              FontAwesomeIcons.rightFromBracket,
              color: Colors.amber[700],
            ),
            title: const Text("Cerrar sesión"),
            onTap: _logout,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: const Text(
            'Versión 1.0.0',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
