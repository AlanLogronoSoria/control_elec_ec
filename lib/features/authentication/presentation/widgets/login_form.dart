/// Widget de formulario de login reutilizable.
library;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/validators/form_validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.cedulaController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onLogin,
    required this.onForgotPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController cedulaController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.login,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Ingresa con tu cédula y contraseña asignada.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 28),
          TextFormField(
            controller: cedulaController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              labelText: AppStrings.cedula,
              prefixIcon: Icon(Icons.badge_outlined),
              counterText: '',
            ),
            validator: FormValidators.cedula,
            enabled: !isLoading,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: AppStrings.password,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: onTogglePassword,
              ),
            ),
            validator: (v) =>
                (v?.isEmpty ?? true) ? 'La contraseña es requerida.' : null,
            enabled: !isLoading,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: isLoading ? null : onForgotPassword,
              child: const Text(AppStrings.forgotPassword),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : onLogin,
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Text(AppStrings.login),
          ),
        ],
      ),
    );
  }
}
