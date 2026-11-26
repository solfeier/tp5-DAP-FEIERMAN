import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp5/providers/auth_provider.dart';
import 'package:tp5/providers/herramientas_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final herramientasAsync = ref.watch(herramientasProvider);
    final authState = ref.watch(authProvider);
    final nombreUsuario = authState.user?.displayName?.trim();
    final saludo = (nombreUsuario != null && nombreUsuario.isNotEmpty)
        ? nombreUsuario
        : (authState.user?.email ?? 'Usuario');

    return Scaffold(
      appBar: AppBar(
        title: Text("Hola, $saludo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: herramientasAsync.isEmpty
          ? const Center(child: Text("No hay herramientas registradas."))
          : ListView.builder(
              itemCount: herramientasAsync.length,
              itemBuilder: (context, index) {
                final prod = herramientasAsync[index];

                return ListTile(
                  leading: Image.network(
                    prod.foto,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.build, size: 40),
                  ),
                  title: Text(prod.nombre),
                  subtitle: Text(
                    "${prod.categoria} · Cantidad: ${prod.cantidad}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/detalle', extra: prod);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/formulario');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}