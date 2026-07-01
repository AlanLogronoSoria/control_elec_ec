/// Pantalla que solicita permiso GPS al usuario.
library;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_strings.dart';

class GpsPermissionScreen extends StatelessWidget {
  const GpsPermissionScreen({super.key, this.onGranted});

  final VoidCallback? onGranted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  size: 64,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Permiso de Ubicación Requerido',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                AppStrings.gpsPermisoDenegado,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'La aplicación necesita acceder a tu ubicación para registrar las coordenadas GPS de cada acta electoral.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textHint, fontSize: 14),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                  onGranted?.call();
                },
                icon: const Icon(Icons.settings),
                label: const Text('Abrir Configuración'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onGranted,
                child: const Text('Ya concedí el permiso'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
