import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp5/entities/herramienta.dart';
import 'package:tp5/providers/herramientas_provider.dart';

class FormHerramientaScreen extends ConsumerStatefulWidget {
  final Herramienta? herramienta;

  const FormHerramientaScreen({super.key, this.herramienta});

  @override
  ConsumerState<FormHerramientaScreen> createState() =>
      _FormHerramientaScreenState();
}

class _FormHerramientaScreenState extends ConsumerState<FormHerramientaScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _cantidadCtrl;
  late TextEditingController _categoriaCtrl;
  late TextEditingController _ubicacionCtrl;
  late TextEditingController _fotoCtrl;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.herramienta?.nombre ?? '');
    _descCtrl = TextEditingController(text: widget.herramienta?.desc ?? '');
    _cantidadCtrl = TextEditingController(
      text: widget.herramienta != null
          ? widget.herramienta!.cantidad.toString()
          : '',
    );
    _categoriaCtrl =
        TextEditingController(text: widget.herramienta?.categoria ?? '');
    _ubicacionCtrl =
        TextEditingController(text: widget.herramienta?.ubicacion ?? '');
    _fotoCtrl = TextEditingController(text: widget.herramienta?.foto ?? '');
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descCtrl.dispose();
    _cantidadCtrl.dispose();
    _categoriaCtrl.dispose();
    _ubicacionCtrl.dispose();
    _fotoCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate() || _guardando) return;

    setState(() => _guardando = true);

    try {
      final esEdicion = widget.herramienta != null;

      final herramientaGuardar = Herramienta(
        id: esEdicion
            ? widget.herramienta!.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        nombre: _nombreCtrl.text.trim(),
        desc: _descCtrl.text.trim(),
        cantidad: int.parse(_cantidadCtrl.text.trim()),
        categoria: _categoriaCtrl.text.trim(),
        ubicacion: _ubicacionCtrl.text.trim(),
        foto: _fotoCtrl.text.trim().isEmpty
            ? 'https://picsum.photos/200'
            : _fotoCtrl.text.trim(),
      );

      if (esEdicion) {
        ref.read(herramientasProvider.notifier).editar(herramientaGuardar);
      } else {
        ref.read(herramientasProvider.notifier).agregar(herramientaGuardar);
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al guardar: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _guardando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.herramienta != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar Herramienta" : "Nueva Herramienta"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (val) => val == null || val.trim().isEmpty
                    ? "Ingrese un nombre"
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: "Descripción"),
                validator: (val) => val == null || val.trim().isEmpty
                    ? "Ingrese una descripción"
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cantidadCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Cantidad"),
                validator: (val) {
                  if (val == null || val.trim().isEmpty || int.tryParse(val.trim()) == null) {
                    return "Ingrese un número válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _categoriaCtrl,
                decoration: const InputDecoration(labelText: "Categoría"),
                validator: (val) => val == null || val.trim().isEmpty
                    ? "Ingrese una categoría"
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ubicacionCtrl,
                decoration: const InputDecoration(labelText: "Ubicación"),
                validator: (val) => val == null || val.trim().isEmpty
                    ? "Ingrese una ubicación"
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _fotoCtrl,
                decoration: const InputDecoration(labelText: "URL de la Foto"),
              ),
              const SizedBox(height: 20),
              _guardando
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _guardar,
                      child: Text(esEdicion ? "Guardar Cambios" : "Crear"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}