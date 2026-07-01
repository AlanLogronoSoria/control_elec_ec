/// Scaffold base para la aplicación con soporte de roles.
///
/// Incluye App Bar, Sync Indicator y Drawer/BottomNav dependiendo del rol.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_strings.dart';
import '../../features/authentication/presentation/providers/auth_provider.dart';
import 'sync_status_indicator.dart';

class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.showBackButton = false,
  });

  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showBackButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        actions: [
          const SyncStatusIndicator(),
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: AppStrings.logout,
              onPressed: () => _showLogoutDialog(context, ref),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro que deseas salir? Las operaciones pendientes de sincronización se mantendrán guardadas localmente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.cancelar),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppStrings.logout),
          ),
        ],
      ),
    );

    if (confirm == true) {
      ref.read(authProvider.notifier).logout();
    }
  }
}
