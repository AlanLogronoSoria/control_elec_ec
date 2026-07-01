/// Pantalla de inicio de sesión.
///
/// Muestra el formulario de cédula + contraseña con validación completa.
/// Redirige según el rol del usuario y si requiere cambio de contraseña.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/validators/form_validators.dart';
import '../../domain/entities/user_entity.dart';
import '../providers/auth_provider.dart';

/// Pantalla de Login.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _cedulaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ── Handlers ───────────────────────────────────────────────────────────

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await ref.read(authProvider.notifier).login(
          cedula: _cedulaController.text.trim(),
          password: _passwordController.text,
        );
  }

  void _handleForgotPassword() {
    context.push('/forgot-password');
  }

  // ── Listener para navegación post-login ───────────────────────────────

  void _navigateAfterLogin(AuthState state) {
    if (state.isLoggedIn && state.user != null) {
      final user = state.user!;

      // Si necesita cambiar contraseña → pantalla de cambio obligatorio
      if (user.requiresPasswordChange) {
        context.go('/change-password');
        return;
      }

      // Redirigir según rol
      switch (user.rol) {
        case UserRole.coordinadorProvincial:
          context.go('/provincial/dashboard');
        case UserRole.coordinadorRecinto:
          context.go('/recinto/dashboard');
        case UserRole.veedorMesa:
          context.go('/veedor/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios de estado para navegación
    ref.listen<AuthState>(authProvider, (prev, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure!.message),
            backgroundColor: AppColors.danger,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      } else if (next.isLoggedIn && !next.isLoading) {
        _navigateAfterLogin(next);
      }
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              Color(0xFF1976D2),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  // ── Header con logo ─────────────────────────────────
                  const Expanded(
                    flex: 2,
                    child: _LoginHeader(),
                  ),

                  // ── Tarjeta de formulario ───────────────────────────
                  Expanded(
                    flex: 3,
                    child: _LoginCard(
                      formKey: _formKey,
                      cedulaController: _cedulaController,
                      passwordController: _passwordController,
                      obscurePassword: _obscurePassword,
                      isLoading: authState.isLoading,
                      onTogglePassword: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      onLogin: _handleLogin,
                      onForgotPassword: _handleForgotPassword,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ────────────────────────────────────────────────────────────────────────────

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Escudo/logo
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.how_to_vote_rounded,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.appName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.appSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
                fontSize: 13,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      child: Form(
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

            // ── Campo Cédula ───────────────────────────────────────
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

            // ── Campo Contraseña ───────────────────────────────────
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
              validator: (v) => (v?.isEmpty ?? true)
                  ? 'La contraseña es requerida.'
                  : null,
              enabled: !isLoading,
            ),
            const SizedBox(height: 10),

            // ── Olvidé contraseña ──────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: isLoading ? null : onForgotPassword,
                child: const Text(AppStrings.forgotPassword),
              ),
            ),
            const SizedBox(height: 20),

            // ── Botón Login ────────────────────────────────────────
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
      ),
    );
  }
}
