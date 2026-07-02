/// Dashboard del Coordinador de Recinto.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../providers/recinto_providers.dart';
import '../../../veedor/presentation/providers/veedor_providers.dart';

class RecintoDashboardScreen extends ConsumerStatefulWidget {
  const RecintoDashboardScreen({super.key});

  @override
  ConsumerState<RecintoDashboardScreen> createState() =>
      _RecintoDashboardScreenState();
}

class _RecintoDashboardScreenState
    extends ConsumerState<RecintoDashboardScreen> {
  String? _precinctId;

  @override
  Widget build(BuildContext context) {
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
              progressAsync.when(
                data: (progress) {
                  _precinctId = progress.precinctId;
                  return _ProgressCard(
                    total: progress.totalMesas,
                    completadas: progress.mesasCompletadas,
                    enProgreso: progress.mesasEnProgreso,
                    pendientes: progress.mesasPendientes,
                    porcentaje: progress.porcentajeCompletado,
                    recintoName: progress.precinctName,
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (err, _) => Card(
                  color: AppColors.danger.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error al cargar progreso: $err',
                        style: const TextStyle(color: AppColors.danger)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Gestión de Recinto',
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
                      icon: Icons.people_outline,
                      title: 'Veedores',
                      subtitle: 'Gestionar asignaciones',
                      onTap: () =>
                          context.push('/recinto/dashboard/veedores'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.how_to_vote_outlined,
                      title: 'Actas',
                      subtitle: 'Revisar escrutinio',
                      onTap: () {
                        final pid = _precinctId;
                        if (pid != null) {
                          _showActsReviewBottomSheet(context, pid);
                        }
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
                onTap: () => _showNovedadDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActsReviewBottomSheet(BuildContext context, String precinctId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ActsReviewSheet(precinctId: precinctId),
    );
  }

  void _showNovedadDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reportar Novedad'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe la incidencia o novedad del recinto...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Novedad registrada exitosamente.'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
              Navigator.pop(ctx);
            },
            child: const Text('Enviar'),
          ),
        ],
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

class _ActsReviewSheet extends ConsumerStatefulWidget {
  const _ActsReviewSheet({required this.precinctId});
  final String precinctId;

  @override
  ConsumerState<_ActsReviewSheet> createState() => _ActsReviewSheetState();
}

class _ActsReviewSheetState extends ConsumerState<_ActsReviewSheet> {
  late Future<_ActsData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_ActsData> _load() async {
    final db = ref.read(appDatabaseProvider);
    final tables = await db.precinctsDao.getTablesByPrecinct(widget.precinctId);
    final Map<String, List<ActsTableData>> actsByTable = {};
    for (final t in tables) {
      final all = await db.actsDao.getActsByTable(t.id);
      actsByTable[t.id] = all
          .where((a) => a.estado == 'guardado' || a.estado == 'sincronizado')
          .toList();
    }
    return _ActsData(tables: tables, actsByTable: actsByTable);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.how_to_vote_outlined, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text('Revisión de Actas',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    setState(() => _future = _load());
                  },
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Actualizar', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<_ActsData>(
              future: _future,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = snapshot.data!;
                if (data.tables.isEmpty) {
                  return const Center(child: Text('No hay mesas registradas.'));
                }
                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: data.tables.length,
                  itemBuilder: (_, i) {
                    final table = data.tables[i];
                    final acts = data.actsByTable[table.id] ?? [];
                    final estado = table.estadoActa;
                    final color = estado == 'completado'
                        ? AppColors.success
                        : estado == 'en_progreso'
                            ? AppColors.warning
                            : AppColors.textHint;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.primaryLight,
                                  child: Text('${table.jrvNumber}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text('JRV #${table.jrvNumber}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(estado,
                                      style: TextStyle(
                                          color: color, fontSize: 10)),
                                ),
                              ],
                            ),
                            if (acts.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              ...acts.map((act) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 36, bottom: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                            act.tipoDignidad == 'alcalde'
                                                ? Icons.account_balance
                                                : Icons.domain,
                                            size: 14,
                                            color:
                                                AppColors.primary),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                              act.tipoDignidad == 'alcalde'
                                                  ? 'Acta Alcalde'
                                                  : 'Acta Prefecto',
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                        ),
                                        _buildTinyButton(
                                          icon: Icons.edit_outlined,
                                          label: 'Corregir',
                                          onTap: () {
                                            Navigator.pop(context);
                                            context.push(
                                              '/recinto/dashboard/corregir/${act.id}',
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTinyButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 28,
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 14),
        label: Text(label, style: const TextStyle(fontSize: 11)),
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
      ),
    );
  }
}

class _ActsData {
  const _ActsData({required this.tables, required this.actsByTable});
  final List<ElectoralTablesTableData> tables;
  final Map<String, List<ActsTableData>> actsByTable;
}
