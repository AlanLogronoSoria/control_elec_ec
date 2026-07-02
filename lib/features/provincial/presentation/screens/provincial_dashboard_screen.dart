/// Dashboard del Coordinador Provincial con estadísticas globales (fl_chart).
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../domain/entities/provincial_entities.dart';
import '../providers/provincial_providers.dart';
import '../../../veedor/presentation/providers/veedor_providers.dart';

class ProvincialDashboardScreen extends ConsumerWidget {
  const ProvincialDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumenAsync = ref.watch(resumenGlobalProvider);

    return AppScaffold(
      title: 'Control Provincial',
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(resumenGlobalProvider.notifier).loadResumen();
          ref.read(avancePorRecintoProvider.notifier).load();
        },
        child: resumenAsync.when(
          data: (resumen) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _GlobalProgressCard(resumen: resumen),
              const SizedBox(height: 24),
              _ChartSection(
                title: 'Alcaldía - Resultados Preliminares',
                estadisticas: resumen.estadisticasAlcalde,
              ),
              const SizedBox(height: 24),
              _ChartSection(
                title: 'Prefectura - Resultados Preliminares',
                estadisticas: resumen.estadisticasPrefecto,
              ),
              const SizedBox(height: 24),
              const _AvancePorRecintoSection(),
              const SizedBox(height: 24),
              _ActionsGrid(),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

class _GlobalProgressCard extends StatelessWidget {
  const _GlobalProgressCard({required this.resumen});
  final ResumenProvincialEntity resumen;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Text('Progreso Provincial de Escrutinio', style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: resumen.porcentajeEscrutado / 100,
                    strokeWidth: 12,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentLight),
                  ),
                ),
                Text(
                  '${resumen.porcentajeEscrutado.toStringAsFixed(1)}%',
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Actas Escrutadas', '${resumen.actasEscrutadas} / ${resumen.totalActas}'),
                _buildStatItem('Total Sufragantes', '${resumen.totalSufragantes}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.accentLight, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class _ChartSection extends StatelessWidget {
  const _ChartSection({required this.title, required this.estadisticas});
  final String title;
  final List<EstadisticaVotosEntity> estadisticas;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < estadisticas.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                estadisticas[value.toInt()].candidatoNombre,
                                style: const TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: estadisticas.asMap().entries.map((entry) {
                    final index = entry.key;
                    final stat = entry.value;
                    // Parse hex color string to Color safely
                    final colorStr = stat.colorHex.replaceAll('#', '');
                    final colorVal = int.tryParse(colorStr, radix: 16) ?? 0xFF000000;
                    final color = Color(colorVal | 0xFF000000); // ensure opacity is FF

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: stat.porcentaje,
                          color: color,
                          width: 20,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...estadisticas.map((s) {
              final colorStr = s.colorHex.replaceAll('#', '');
              final colorVal = int.tryParse(colorStr, radix: 16) ?? 0xFF000000;
              final color = Color(colorVal | 0xFF000000);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(width: 12, height: 12, color: color),
                    const SizedBox(width: 8),
                    Expanded(child: Text(s.organizacionNombre, style: const TextStyle(fontSize: 12))),
                    Text('${s.porcentaje}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gestión Provincial',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.location_city,
                title: 'Recintos',
                subtitle: 'Ver y crear recintos',
                onTap: () =>
                    context.push('/provincial/recintos'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionCard(
                icon: Icons.person_add,
                title: 'Coordinadores',
                subtitle: 'Crear coordinadores',
                onTap: () =>
                    context.push('/provincial/crear-coordinador'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.assignment_ind,
                title: 'Asignar Coordinador',
                subtitle: 'Vincular a recinto',
                onTap: () =>
                    context.push('/provincial/asignar-coordinador'),
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: 12),
            const Spacer(flex: 1),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color = AppColors.primary,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: const TextStyle(
                    color: AppColors.textHint, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _AvancePorRecintoSection extends ConsumerStatefulWidget {
  const _AvancePorRecintoSection();

  @override
  ConsumerState<_AvancePorRecintoSection> createState() =>
      _AvancePorRecintoSectionState();
}

class _AvancePorRecintoSectionState
    extends ConsumerState<_AvancePorRecintoSection> {
  final _expandedPrecincts = <String>{};
  final Map<String, List<ElectoralTablesTableData>> _tablesByPrecinct = {};
  final Map<String, List<ActsTableData>> _actsByTable = {};
  bool _loaded = false;

  Future<void> _togglePrecinct(String precinctId) async {
    if (_expandedPrecincts.contains(precinctId)) {
      setState(() => _expandedPrecincts.remove(precinctId));
      return;
    }
    if (!_loaded) {
      final db = ref.read(appDatabaseProvider);
      final precincts = await db.precinctsDao.getAllPrecincts();
      for (final p in precincts) {
        final tables = await db.precinctsDao.getTablesByPrecinct(p.id);
        _tablesByPrecinct[p.id] = tables;
        for (final t in tables) {
          final all = await db.actsDao.getActsByTable(t.id);
          _actsByTable[t.id] =
              all.where((a) =>
                  a.estado == 'guardado' || a.estado == 'sincronizado').toList();
        }
      }
      _loaded = true;
    }
    setState(() => _expandedPrecincts.add(precinctId));
  }

  @override
  Widget build(BuildContext context) {
    final avanceAsync = ref.watch(avancePorRecintoProvider);

    return avanceAsync.when(
      data: (recintos) {
        if (recintos.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avance por Recinto',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...recintos.map((r) {
              final isExpanded = _expandedPrecincts.contains(r.precinctId);
              final tables = _tablesByPrecinct[r.precinctId] ?? [];
              return _RecintoAvanceCard(
                recinto: r,
                isExpanded: isExpanded,
                tables: tables,
                actsByTable: _actsByTable,
                onToggle: () => _togglePrecinct(r.precinctId),
              );
            }),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}

class _RecintoAvanceCard extends StatelessWidget {
  const _RecintoAvanceCard({
    required this.recinto,
    required this.isExpanded,
    required this.tables,
    required this.actsByTable,
    required this.onToggle,
  });

  final AvanceRecintoEntity recinto;
  final bool isExpanded;
  final List<ElectoralTablesTableData> tables;
  final Map<String, List<ActsTableData>> actsByTable;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isComplete = recinto.porcentajeCompletado >= 100;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (isComplete
                              ? AppColors.success
                              : AppColors.primary)
                          .withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_city,
                      size: 20,
                      color:
                          isComplete ? AppColors.success : AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recinto.precinctName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          '${recinto.provincia} › ${recinto.canton} › ${recinto.parroquia}',
                          style: const TextStyle(
                              color: AppColors.textHint, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${recinto.porcentajeCompletado.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isComplete
                              ? AppColors.success
                              : AppColors.primary,
                        ),
                      ),
                      Text(
                        '${recinto.mesasCompletadas}/${recinto.totalMesas} mesas',
                        style: const TextStyle(
                            color: AppColors.textHint, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: AppColors.textHint,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: recinto.totalMesas == 0
                      ? 0
                      : recinto.mesasCompletadas / recinto.totalMesas,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      isComplete ? AppColors.success : AppColors.primary),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _MiniStat(
                    icon: Icons.account_balance,
                    label: 'Alcalde',
                    value: '${recinto.votosAlcalde}',
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 24),
                  _MiniStat(
                    icon: Icons.domain,
                    label: 'Prefecto',
                    value: '${recinto.votosPrefecto}',
                    color: AppColors.accent,
                  ),
                  const Spacer(),
                  _MiniStat(
                    icon: Icons.check_circle_outline,
                    label: 'Completadas',
                    value: '${recinto.mesasCompletadas}',
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 24),
                  _MiniStat(
                    icon: Icons.pending_outlined,
                    label: 'Pendientes',
                    value: '${recinto.mesasPendientes}',
                    color: AppColors.warningDark,
                  ),
                ],
              ),
              if (isExpanded && tables.isNotEmpty) ...[
                const Divider(height: 24),
                Text(
                  'Actas registradas',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textHint),
                ),
                const SizedBox(height: 8),
                ...tables.map((table) {
                  final acts = actsByTable[table.id] ?? [];
                  if (acts.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'JRV #${table.jrvNumber}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        ...acts.map((act) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 4, bottom: 2),
                              child: Row(
                                children: [
                                  Icon(
                                    act.tipoDignidad == 'alcalde'
                                        ? Icons.account_balance
                                        : Icons.domain,
                                    size: 14,
                                    color: act.tipoDignidad == 'alcalde'
                                        ? AppColors.primary
                                        : AppColors.accent,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      act.tipoDignidad == 'alcalde'
                                          ? 'Acta Alcalde'
                                          : 'Acta Prefecto',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 28,
                                    child: TextButton.icon(
                                      onPressed: () => context.push(
                                        '/provincial/dashboard/acta/${act.id}',
                                      ),
                                      icon: const Icon(
                                          Icons.visibility_outlined,
                                          size: 14),
                                      label: const Text('Ver',
                                          style: TextStyle(fontSize: 11)),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        minimumSize: const Size(0, 28),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textHint,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
