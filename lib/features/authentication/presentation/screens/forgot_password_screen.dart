/// Pantalla de recuperación de contraseña mediante cédula.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/validators/form_validators.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _cedulaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await ref.read(authProvider.notifier).sendForgotPassword(
          cedula: _cedulaController.text.trim(),
        );

    if (success && mounted) {
      setState(() => _submitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (prev, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure!.message),
            backgroundColor: AppColors.danger,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.recoverPassword),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _submitted
              ? _SuccessView(
                  cedula: _cedulaController.text,
                  onBackToLogin: () => context.go('/login'),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lock_reset_rounded,
                        size: 48,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Recupera tu acceso',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ingresa tu número de cédula y solicita a tu coordinador que restablezca tu contraseña.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _cedulaController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: AppStrings.cedula,
                          prefixIcon: Icon(Icons.badge_outlined),
                          counterText: '',
                        ),
                        validator: FormValidators.cedula,
                        enabled: !authState.isLoading,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: authState.isLoading ? null : _submit,
                        child: authState.isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Solicitar Restablecimiento'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({
    required this.cedula,
    required this.onBackToLogin,
  });

  final String cedula;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_outline,
            size: 64,
            color: AppColors.success,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Solicitud enviada',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Se ha enviado un enlace de recuperación al correo electrónico registrado para la cédula:\n$cedula',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Revisa tu bandeja de entrada o carpeta de spam.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: onBackToLogin,
          child: const Text('Volver al Login'),
        ),
      ],
    );
  }
}
