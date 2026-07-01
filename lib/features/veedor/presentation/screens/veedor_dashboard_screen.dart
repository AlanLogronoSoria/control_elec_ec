/// Dashboard principal del Veedor de Mesa.
///
/// Muestra las mesas asignadas y permite iniciar el escrutinio de cada una.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../domain/entities/acta_entity.dart';
import '../providers/veedor_providers.dart';

class VeedorDashboardScreen extends ConsumerWidget {
  const VeedorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tablesAsync = ref.watch(tablesProvider);

    return AppScaffold(
      title: 'Panel de Veedor',
      body: RefreshIndicator(
        onRefresh: () => ref.read(tablesProvider.notifier).loadTables(),
        child: tablesAsync.when(
          data: (tables) {
            if (tables.isEmpty) {
              return _EmptyTablesView(
                onRefresh: () => ref.read(tablesProvider.notifier).loadTables(),
              );
            }
            return _TablesListView(tables: tables);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: AppColors.danger, size: 48),
                const SizedBox(height: 16),
                Text('Error al cargar mesas:\n$err', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(tablesProvider.notifier).loadTables(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TablesListView extends StatelessWidget {
  const _TablesListView({required this.tables});
  final List<MesaElectoralEntity> tables;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tables.length,
      itemBuilder: (context, index) {
        final table = tables[index];
        return _TableCard(table: table);
      },
    );
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard({required this.table});
  final MesaElectoralEntity table;

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = table.estadoActa == 'completado';
    final bool isInProgress = table.estadoActa == 'en_progreso';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Si está completado, tal vez no dejar editar, o dejar ver un resumen
          context.push('/veedor/dashboard/acta/${table.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.success.withOpacity(0.1)
                      : isInProgress
                          ? AppColors.warning.withOpacity(0.1)
                          : AppColors.primaryLight.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${table.jrvNumber}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? AppColors.success
                          : isInProgress
                              ? AppColors.warningDark
                              : AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Junta Receptora del Voto',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                    ),
                    Text(
                      table.precinctName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      table.parroquia,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _StatusBadge(status: table.estadoActa),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'completado':
        color = AppColors.success;
        text = 'Listo';
        icon = Icons.check_circle;
        break;
      case 'en_progreso':
        color = AppColors.warning;
        text = 'En Progreso';
        icon = Icons.pending;
        break;
      case 'pendiente':
      default:
        color = AppColors.textHint;
        text = 'Pendiente';
        icon = Icons.hourglass_empty;
    }

    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EmptyTablesView extends StatelessWidget {
  const _EmptyTablesView({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_ind_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text(
            'Sin mesas asignadas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aún no tienes mesas asignadas para el escrutinio.\nContacta con tu coordinador de recinto.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textHint),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }
}
