/// Pantalla para que el Coordinador de Recinto cree un nuevo Veedor.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/validators/form_validators.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

class CreateVeedorScreen extends ConsumerStatefulWidget {
  const CreateVeedorScreen({super.key});

  @override
  ConsumerState<CreateVeedorScreen> createState() => _CreateVeedorScreenState();
}

class _CreateVeedorScreenState extends ConsumerState<CreateVeedorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await ref.read(authProvider.notifier).createUser(
          cedula: _cedulaController.text.trim(),
          nombres: _nombresController.text.trim(),
          apellidos: _apellidosController.text.trim(),
          telefono: _telefonoController.text.trim(),
          correo: _correoController.text.trim(),
          rol: UserRole.veedorMesa,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veedor creado exitosamente. Debes iniciar sesión nuevamente.'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Veedor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _cedulaController,
                decoration: const InputDecoration(
                  labelText: 'Cédula',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: FormValidators.cedula,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombresController,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) => FormValidators.nombres(v, fieldName: 'El nombre'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) => FormValidators.nombres(v, fieldName: 'El apellido'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: FormValidators.phone,
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: FormValidators.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: authState.isLoading ? null : _submit,
                child: authState.isLoading
                    ? const SizedBox(
                        height: 22, width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : const Text('Crear Veedor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
