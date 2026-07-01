/// Dashboard del Coordinador de Recinto.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../providers/recinto_providers.dart';

class RecintoDashboardScreen extends ConsumerWidget {
  const RecintoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(recintoProgressProvider);

    return AppScaffold(
      title: 'Coordinación de Recinto',
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(recintoProgressProvider.notifier).loadProgress();
          ref.read(veedoresProvider.notifier).loadVeedores();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Panel Superior (Progreso) ───────────────────────────
              progressAsync.when(
                data: (progress) => _ProgressCard(
                  total: progress.totalMesas,
                  completadas: progress.mesasCompletadas,
                  enProgreso: progress.mesasEnProgreso,
                  pendientes: progress.mesasPendientes,
                  porcentaje: progress.porcentajeCompletado,
                  recintoName: progress.precinctName,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Card(
                  color: AppColors.danger.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error al cargar progreso: $err', style: const TextStyle(color: AppColors.danger)),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              
              // ── Acciones Rápidas ────────────────────────────────────
              Text(
                'Gestión de Recinto',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.people_outline,
                      title: 'Veedores',
                      subtitle: 'Gestionar asignaciones',
                      onTap: () => context.push('/recinto/dashboard/veedores'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.how_to_vote_outlined,
                      title: 'Actas',
                      subtitle: 'Revisar escrutinio',
                      onTap: () {
                        // Navegar a listado de actas
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('En desarrollo')));
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              _ActionCard(
                icon: Icons.warning_amber_rounded,
                title: 'Novedades',
                subtitle: 'Reportar incidencia en recinto',
                color: AppColors.warning,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('En desarrollo')));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.total,
    required this.completadas,
    required this.enProgreso,
    required this.pendientes,
    required this.porcentaje,
    required this.recintoName,
  });

  final int total;
  final int completadas;
  final int enProgreso;
  final int pendientes;
  final double porcentaje;
  final String recintoName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.accentLight),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recintoName,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${porcentaje.toStringAsFixed(1)}%',
                  style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, height: 1.0),
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('completado', style: TextStyle(color: Colors.white70, fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: total == 0 ? 0 : completadas / total,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentLight),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatColumn(label: 'Total', value: '$total', color: Colors.white),
                _StatColumn(label: 'Listas', value: '$completadas', color: AppColors.success),
                _StatColumn(label: 'Progreso', value: '$enProgreso', color: AppColors.warning),
                _StatColumn(label: 'Faltan', value: '$pendientes', color: Colors.white70),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
