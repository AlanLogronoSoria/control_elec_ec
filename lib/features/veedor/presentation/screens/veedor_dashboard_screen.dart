/// Dashboard principal del Veedor de Mesa.
///
/// Muestra las mesas asignadas, las actas registradas en cada mesa
/// y permite iniciar el escrutinio o corregir actas existentes.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/acta_entity.dart';
import '../providers/veedor_providers.dart';

class VeedorDashboardScreen extends ConsumerStatefulWidget {
  const VeedorDashboardScreen({super.key});

  @override
  ConsumerState<VeedorDashboardScreen> createState() =>
      _VeedorDashboardScreenState();
}

class _VeedorDashboardScreenState extends ConsumerState<VeedorDashboardScreen> {
  final Map<String, List<ActsTableData>> _actsByTable = {};
  bool _actsLoaded = false;

  Future<void> _loadActsForTables(List<MesaElectoralEntity> tables) async {
    if (_actsLoaded) return;
    final db = ref.read(appDatabaseProvider);
    for (final table in tables) {
      final allActs = await db.actsDao.getActsByTable(table.id);
      final registered = allActs
          .where((a) => a.estado == 'guardado' || a.estado == 'sincronizado')
          .toList();
      if (registered.isNotEmpty) {
        _actsByTable[table.id] = registered;
      }
    }
    if (mounted) {
      setState(() => _actsLoaded = true);
    }
  }

  Future<void> _refresh() async {
    _actsByTable.clear();
    _actsLoaded = false;
    await ref.read(tablesProvider.notifier).loadTables();
  }

  @override
  Widget build(BuildContext context) {
    final tablesAsync = ref.watch(tablesProvider);

    return AppScaffold(
      title: 'Panel de Veedor',
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: tablesAsync.when(
          data: (tables) {
            if (tables.isEmpty) {
              return _EmptyTablesView(
                onRefresh: () => _refresh(),
              );
            }
            _loadActsForTables(tables);
            return _TablesListView(tables: tables, actsByTable: _actsByTable);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: AppColors.danger, size: 48),
                const SizedBox(height: 16),
                Text('Error al cargar mesas:\n$err',
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(tablesProvider.notifier).loadTables(),
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
  const _TablesListView({
    required this.tables,
    required this.actsByTable,
  });
  final List<MesaElectoralEntity> tables;
  final Map<String, List<ActsTableData>> actsByTable;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tables.length,
      itemBuilder: (context, index) {
        final table = tables[index];
        final acts = actsByTable[table.id] ?? [];
        return _TableCard(table: table, acts: acts);
      },
    );
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard({required this.table, required this.acts});
  final MesaElectoralEntity table;
  final List<ActsTableData> acts;

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = table.estadoActa == 'completado';
    final bool isInProgress = table.estadoActa == 'en_progreso';
    final bool hasActs = acts.isNotEmpty;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () =>
            context.push('/veedor/dashboard/acta/${table.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
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
              if (hasActs) ...[
                const Divider(height: 24),
                Text(
                  'Actas registradas',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textHint),
                ),
                const SizedBox(height: 8),
                ...acts.map((act) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(
                            act.tipoDignidad == 'alcalde'
                                ? Icons.account_balance
                                : Icons.domain,
                            size: 16,
                            color: act.tipoDignidad == 'alcalde'
                                ? AppColors.primary
                                : AppColors.accent,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              act.tipoDignidad == 'alcalde'
                                  ? 'Acta Alcalde'
                                  : 'Acta Prefecto',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          Text(
                            act.estado == 'sincronizado'
                                ? 'Sincronizada'
                                : 'Guardada',
                            style: TextStyle(
                              fontSize: 11,
                              color: act.estado == 'sincronizado'
                                  ? AppColors.success
                                  : AppColors.textHint,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 20),
                            color: AppColors.primary,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: 'Corregir acta',
                            onPressed: () {
                              context.push(
                                '/veedor/dashboard/corregir/${act.id}',
                              );
                            },
                          ),
                        ],
                      ),
                    )),
              ],
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
