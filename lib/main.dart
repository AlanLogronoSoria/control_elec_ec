import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'core/services/injection_container.dart';
import 'core/services/sync_service.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';

void main() async {
  // Asegurar que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  final logger = Logger();
  logger.i('Iniciando Control Electoral Ecuador 2026...');

  try {
    // 1. Inicializar inyección de dependencias (GetIt)
    await initDependencies();

    // 2. Correr la aplicación dentro de un ProviderScope (Riverpod)
    runApp(
      const ProviderScope(
        child: _AppRunner(),
      ),
    );
  } catch (e, stackTrace) {
    logger.e('Error fatal al iniciar la aplicación', error: e, stackTrace: stackTrace);
    runApp(_FatalErrorApp(error: e.toString()));
  }
}

/// Widget intermedio para inicializar lógica asíncrona post-arranque.
class _AppRunner extends ConsumerStatefulWidget {
  const _AppRunner();

  @override
  ConsumerState<_AppRunner> createState() => _AppRunnerState();
}

class _AppRunnerState extends ConsumerState<_AppRunner> {
  @override
  void initState() {
    super.initState();
    // Ejecutar inicializaciones después de que el widget tree esté construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. Verificar sesión activa
      ref.read(authProvider.notifier).checkSession();

      // 2. Iniciar el servicio de sincronización en background
      sl<SyncService>().start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ElectoralApp();
  }
}

/// Widget a mostrar si falla la inicialización de dependencias críticas.
class _FatalErrorApp extends StatelessWidget {
  const _FatalErrorApp({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Error de Inicialización',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  error,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
