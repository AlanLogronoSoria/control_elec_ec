/// Dashboard del Coordinador Provincial con estadísticas globales (fl_chart).
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../domain/entities/provincial_entities.dart';
import '../providers/provincial_providers.dart';

class ProvincialDashboardScreen extends ConsumerWidget {
  const ProvincialDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumenAsync = ref.watch(resumenGlobalProvider);

    return AppScaffold(
      title: 'Control Provincial',
      body: RefreshIndicator(
        onRefresh: () => ref.read(resumenGlobalProvider.notifier).loadResumen(),
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
