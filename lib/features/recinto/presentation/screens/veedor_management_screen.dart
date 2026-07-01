/// Pantalla de Gestión de Veedores para el Coordinador de Recinto.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/recinto_providers.dart';

class VeedorManagementScreen extends ConsumerWidget {
  const VeedorManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veedoresAsync = ref.watch(veedoresProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Veedores')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(veedoresProvider.notifier).loadVeedores(),
        child: veedoresAsync.when(
          data: (veedores) {
            if (veedores.isEmpty) {
              return const Center(child: Text('No hay veedores registrados en este recinto.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: veedores.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final v = veedores[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      child: Text(
                        v.user.nombres.substring(0, 1) + v.user.apellidos.substring(0, 1),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('${v.user.nombres} ${v.user.apellidos}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('C.I: ${v.user.cedula}'),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8,
                          children: v.mesasAsignadas.map((mesa) => Chip(
                            label: Text('JRV $mesa', style: const TextStyle(fontSize: 10)),
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            padding: EdgeInsets.zero,
                          )).toList(),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (val) {
                        if (val == 'asignar') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Flujo de asignación de mesa en desarrollo')));
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'asignar', child: Text('Asignar Mesa')),
                        const PopupMenuItem(value: 'contactar', child: Text('Llamar Veedor')),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Creación de Veedor en desarrollo')));
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Nuevo Veedor'),
      ),
    );
  }
}
