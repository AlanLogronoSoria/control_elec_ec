/// Widget raíz de la aplicación.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

class ElectoralApp extends ConsumerWidget {
  const ElectoralApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Cambia automáticamente según el SO
      routerConfig: router,
    );
  }
}
