/// Overlay de carga que cubre toda la pantalla.
library;

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    this.message = 'Cargando...',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: AppColors.primary),
                const SizedBox(height: 16),
                Text(message, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
