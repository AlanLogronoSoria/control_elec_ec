/// Pantalla para que el Coordinador Provincial cree un nuevo recinto.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/database/app_database.dart';


class CreatePrecinctScreen extends ConsumerStatefulWidget {
  const CreatePrecinctScreen({super.key});

  @override
  ConsumerState<CreatePrecinctScreen> createState() => _CreatePrecinctScreenState();
}

class _CreatePrecinctScreenState extends ConsumerState<CreatePrecinctScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _cantonController = TextEditingController();
  final _parroquiaController = TextEditingController();
  int _numeroJrv = 1;

  @override
  void dispose() {
    _nombreController.dispose();
    _provinciaController.dispose();
    _cantonController.dispose();
    _parroquiaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final db = sl<AppDatabase>();
    final id = const Uuid().v4();

    await db.precinctsDao.upsertPrecinct(PrecinctsTableCompanion.insert(
      id: id,
      provincia: _provinciaController.text.trim(),
      canton: _cantonController.text.trim(),
      parroquia: _parroquiaController.text.trim(),
      nombreRecinto: _nombreController.text.trim(),
      numeroJrv: _numeroJrv,
    ));

    // Generar mesas electorales automáticamente (1..numeroJrv)
    await db.precinctsDao.createTablesForPrecinct(
      precinctId: id,
      numeroJrv: _numeroJrv,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recinto creado con $_numeroJrv mesa(s) electoral(es)'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Recinto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Recinto',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _provinciaController,
                decoration: const InputDecoration(
                  labelText: 'Provincia',
                  prefixIcon: Icon(Icons.map),
                ),
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cantonController,
                decoration: const InputDecoration(
                  labelText: 'Cantón',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _parroquiaController,
                decoration: const InputDecoration(
                  labelText: 'Parroquia',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
                validator: (v) => (v?.trim().isEmpty ?? true) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: '1',
                decoration: const InputDecoration(
                  labelText: 'Número de JRV',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 1) return 'Debe ser un número válido';
                  return null;
                },
                onChanged: (v) => _numeroJrv = int.tryParse(v) ?? 1,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Guardar Recinto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
