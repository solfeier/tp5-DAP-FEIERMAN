import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp5/entities/herramienta.dart';
import 'package:tp5/providers/herramientas_provider.dart';

class DetalleScreen extends ConsumerWidget {
  final Herramienta product;

  const DetalleScreen({super.key, required this.product});

  Future<void> _confirmarEliminacion(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Eliminar herramienta"),
        content: const Text(
          "¿Estás seguro de que querés eliminar este elemento?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      ref.read(herramientasProvider.notifier).eliminar(id);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final herramientas = ref.watch(herramientasProvider);
    final herramientaActualizada = herramientas
            .where((h) => h.id == product.id)
            .firstOrNull ??
        product;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Elemento"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/formulario', extra: herramientaActualizada);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmarEliminacion(
              context,
              ref,
              herramientaActualizada.id,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              herramientaActualizada.foto,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey,
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              herramientaActualizada.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Descripción informativa:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(herramientaActualizada.desc),
            const SizedBox(height: 15),
            const Text(
              "Cantidad en Stock:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${herramientaActualizada.cantidad} unidades"),
            const SizedBox(height: 15),
            const Text(
              "Categoría:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(herramientaActualizada.categoria),
            const SizedBox(height: 15),
            const Text(
              "Ubicación:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(herramientaActualizada.ubicacion),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}