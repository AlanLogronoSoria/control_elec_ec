/// Pantalla de Gestión de Veedores para el Coordinador de Recinto.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/usecases/recinto_usecases.dart';
import '../providers/recinto_providers.dart';
import '../../../veedor/presentation/providers/veedor_providers.dart';

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
                          _showAssignTableDialog(context, ref, v.user.id);
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
        onPressed: () => context.push('/recinto/dashboard/crear-veedor'),
        icon: const Icon(Icons.person_add),
        label: const Text('Nuevo Veedor'),
      ),
    );
  }

  void _showAssignTableDialog(
      BuildContext context, WidgetRef ref, String veedorId) {
    showDialog(
      context: context,
      builder: (ctx) => _AssignTableDialog(veedorId: veedorId),
    );
  }
}

class _AssignTableDialog extends ConsumerStatefulWidget {
  const _AssignTableDialog({required this.veedorId});
  final String veedorId;

  @override
  ConsumerState<_AssignTableDialog> createState() => _AssignTableDialogState();
}

class _AssignTableDialogState extends ConsumerState<_AssignTableDialog> {
  late Future<List<ElectoralTablesTableData>> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadTables();
  }

  Future<List<ElectoralTablesTableData>> _loadTables() async {
    final db = ref.read(appDatabaseProvider);
    final allTables = await db.precinctsDao.getAllTables();
    return allTables.where((t) => t.veedorId == null).toList();
  }

  Future<void> _assign(String tableId) async {
    final useCase = ref.read(assignTableUseCaseProvider);
    final result = await useCase(tableId: tableId, veedorId: widget.veedorId);
    if (mounted) {
      result.fold(
        (f) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(f.message), backgroundColor: AppColors.danger),
        ),
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mesa asignada exitosamente.'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Asignar Mesa al Veedor'),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder<List<ElectoralTablesTableData>>(
          future: _future,
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final tables = snapshot.data ?? [];
            if (tables.isEmpty) {
              return const Text('No hay mesas disponibles para asignar.',
                  style: TextStyle(color: AppColors.textHint));
            }
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: tables.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final t = tables[i];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primaryLight,
                      child: Text('${t.jrvNumber}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11)),
                    ),
                    title: Text('JRV #${t.jrvNumber}',
                        style: const TextStyle(fontSize: 13)),
                    trailing: TextButton(
                      onPressed: () => _assign(t.id),
                      child: const Text('Asignar', style: TextStyle(fontSize: 12)),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
