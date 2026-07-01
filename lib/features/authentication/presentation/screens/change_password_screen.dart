/// Pantalla de cambio obligatorio de contraseña (primer login).
///
/// El usuario NO puede acceder al sistema hasta completar este paso.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/validators/form_validators.dart';
import '../../domain/entities/user_entity.dart';
import '../providers/auth_provider.dart';

/// Pantalla de cambio obligatorio de contraseña.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await ref.read(authProvider.notifier).changePassword(
          oldPassword: AppConstants.defaultPassword,
          newPassword: _newPasswordController.text,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.passwordChangedSuccess),
          backgroundColor: AppColors.success,
        ),
      );

      // Navegar al dashboard según el rol
      final user = ref.read(authProvider).user;
      if (user != null) {
        _navigateToDashboard(user);
      }
    }
  }

  void _navigateToDashboard(UserEntity user) {
    switch (user.rol) {
      case UserRole.coordinadorProvincial:
        context.go('/provincial/dashboard');
      case UserRole.coordinadorRecinto:
        context.go('/recinto/dashboard');
      case UserRole.veedorMesa:
        context.go('/veedor/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Mostrar error si existe
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryDark, AppColors.primary],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        size: 48,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.changePassword,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accentLight.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.accent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppStrings.mustChangePassword,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Formulario ─────────────────────────────────────────
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Establece tu nueva contraseña',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Debe tener al menos 8 caracteres, incluir mayúscula y número.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 28),

                        // Nueva contraseña
                        TextFormField(
                          controller: _newPasswordController,
                          obscureText: _obscureNew,
                          decoration: InputDecoration(
                            labelText: AppStrings.newPassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureNew
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () =>
                                  setState(() => _obscureNew = !_obscureNew),
                            ),
                          ),
                          validator: FormValidators.password,
                          enabled: !authState.isLoading,
                        ),
                        const SizedBox(height: 16),

                        // Confirmar contraseña
                        TextFormField(
                          controller: _confirmController,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            labelText: AppStrings.confirmPassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirm
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          validator: FormValidators.confirmPassword(
                            _newPasswordController.text,
                          ),
                          enabled: !authState.isLoading,
                        ),
                        const SizedBox(height: 32),

                        // Botón
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
                              : const Text('Guardar Nueva Contraseña'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
