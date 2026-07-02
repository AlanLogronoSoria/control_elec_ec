/// Pantalla de listado de recintos para el Coordinador Provincial.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/provincial_entities.dart';
import '../providers/provincial_providers.dart';

class PrecinctListScreen extends ConsumerWidget {
  const PrecinctListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(precinctListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recintos Electorales')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(precinctListProvider.notifier).load(),
        child: listAsync.when(
          data: (list) => list.isEmpty
              ? const Center(child: Text('No hay recintos registrados.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final p = list[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.provincialColor,
                          child: const Icon(Icons.location_city, color: Colors.white, size: 20),
                        ),
                        title: Text(p.precinctName,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${p.provincia} › ${p.canton} › ${p.parroquia}'),
                        trailing: Text('JRV: ${p.totalMesas}',
                            style: const TextStyle(color: AppColors.textHint)),
                      ),
                    );
                  },
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/provincial/crear-recinto'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Recinto'),
      ),
    );
  }
}
