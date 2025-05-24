import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_notes/core/database/database_helper.dart';
import 'package:app_notes/features/register/presentation/bloc/barrel_register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _emailError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  String? _confirmPasswordErrorMessage;

  void _onRegisterPressed() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    setState(() {
      _emailError = email.isEmpty || !email.contains('@');
      _passwordError = password.isEmpty;
      _confirmPasswordError = confirmPassword != password;

      _emailErrorMessage =
          email.isEmpty
              ? "El correo es obligatorio"
              : (!email.contains('@') ? "Correo electrónico inválido" : null);

      _passwordErrorMessage =
          password.isEmpty ? "La contraseña es obligatoria" : null;

      _confirmPasswordErrorMessage =
          confirmPassword != password ? "Las contraseñas no coinciden" : null;
    });

    if (!_emailError && !_passwordError && !_confirmPasswordError) {
      context.read<RegisterBloc>().add(RegisterUserRequested(email, password));
    }
  }

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              children: [
                const TextSpan(text: 'Clipen'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    FontAwesomeIcons.pencil,
                    color: Colors.amber,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text("Registro exitoso"),
                    content: const Text(
                      "Tu cuenta ha sido creada correctamente.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text("Aceptar"),
                      ),
                    ],
                  ),
            );
          } else if (state is RegisterFailure) {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text("Alerta"),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Aceptar"),
                      ),
                    ],
                  ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Registro de usuario',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Ingresa tu correo electrónico y crea una contraseña',
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      errorText: _emailError ? _emailErrorMessage : null,
                      border: _buildBorder(Colors.grey.shade400),
                      focusedBorder: _buildBorder(
                        _emailError ? Colors.red : Colors.amber,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      errorText: _passwordError ? _passwordErrorMessage : null,
                      border: _buildBorder(Colors.grey.shade400),
                      focusedBorder: _buildBorder(
                        _passwordError ? Colors.red : Colors.amber,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar contraseña',
                      errorText:
                          _confirmPasswordError
                              ? _confirmPasswordErrorMessage
                              : null,
                      border: _buildBorder(Colors.grey.shade400),
                      focusedBorder: _buildBorder(
                        _confirmPasswordError ? Colors.red : Colors.amber,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:
                        state is RegisterLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed: _onRegisterPressed,
                              child: const Text('Registrarse'),
                            ),
                  ),
                  const SizedBox(height: 10),

                  //Prueba de limpieza de la tabla usuarios
                  ElevatedButton(
                    onPressed: () async {
                      await DatabaseHelper.instance.clearUsuarios();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tabla de usuarios limpiada"),
                        ),
                      );
                    },
                    child: const Text("Limpiar usuarios"),
                  ),
                  //Prueba de limpieza de la tabla usuarios
                  
                  TextButton(
                    onPressed:
                        () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text("Volver"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: const [
                    TextSpan(text: 'Clipen'),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        FontAwesomeIcons.pencil,
                        color: Colors.amber,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Versión 1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
