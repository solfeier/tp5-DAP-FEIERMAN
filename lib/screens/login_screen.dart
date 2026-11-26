import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp5/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _ingresar() async {
    if (!_formKey.currentState!.validate()) return;

    final exito = await ref.read(authProvider.notifier).login(
          userController.text.trim(),
          passwordController.text.trim(),
        );

    if (!mounted) return;

    if (exito) {
      context.go('/home');
    } else {
      final mensaje = ref.read(authProvider).errorMessage ??
          'Correo o contraseña incorrectos';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Ingresar")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: userController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Ingrese su email";
                  }
                  if (!value.contains('@')) {
                    return "Ingrese un email válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese su contraseña";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              authState.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _ingresar,
                      child: const Text("Iniciar Sesión"),
                    ),
              TextButton(
                onPressed: authState.isLoading
                    ? null
                    : () => context.push('/register'),
                child: const Text("¿No tienes cuenta? Regístrate aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}