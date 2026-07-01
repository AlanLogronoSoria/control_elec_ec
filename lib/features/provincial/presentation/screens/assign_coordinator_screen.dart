/// Pantalla para asignar un coordinador de recinto a un recinto electoral.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../../authentication/domain/entities/user_entity.dart';

class AssignCoordinatorScreen extends ConsumerStatefulWidget {
  const AssignCoordinatorScreen({super.key});

  @override
  ConsumerState<AssignCoordinatorScreen> createState() =>
      _AssignCoordinatorScreenState();
}

class _AssignCoordinatorScreenState
    extends ConsumerState<AssignCoordinatorScreen> {
  final _db = sl<AppDatabase>();

  List<UsersTableData> _coordinators = [];
  List<PrecinctsTableData> _precincts = [];
  bool _loading = true;

  String? _selectedCoordinatorId;
  String? _selectedPrecinctId;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final coords = await _db.usersDao.getUsersByRole(
      UserRole.coordinadorRecinto.value,
    );
    final precs = await _db.precinctsDao.getAllPrecincts();
    if (mounted) {
      setState(() {
        _coordinators = coords;
        _precincts = precs;
        _loading = false;
      });
    }
  }

  Future<void> _assign() async {
    if (_selectedCoordinatorId == null || _selectedPrecinctId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona un coordinador y un recinto.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      await (_db.update(_db.precinctsTable)
            ..where((t) => t.id.equals(_selectedPrecinctId!)))
          .write(
        PrecinctsTableCompanion(
          coordinadorRecintoId: Value(_selectedCoordinatorId),
        ),
      );

      if (mounted) {
        final coord = _coordinators.firstWhere(
          (c) => c.id == _selectedCoordinatorId,
        );
        final prec = _precincts.firstWhere(
          (p) => p.id == _selectedPrecinctId,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${coord.nombres} ${coord.apellidos} asignado a ${prec.nombreRecinto}',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asignar Coordinador a Recinto')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── Coordinadores ────────────────────────────────────
                Text(
                  'Coordinadores disponibles',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_coordinators.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: AppColors.textHint),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'No hay coordinadores de recinto. Crea uno primero.',
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.push('/provincial/crear-coordinador'),
                            child: const Text('Crear'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ..._coordinators.map((c) {
                  final selected = _selectedCoordinatorId == c.id;
                  return Card(
                    color: selected
                        ? AppColors.primary.withOpacity(0.08)
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: selected
                          ? const BorderSide(
                              color: AppColors.primary, width: 2)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.recintoColor,
                        child: Text(
                          '${c.nombres[0]}${c.apellidos[0]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text('${c.nombres} ${c.apellidos}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('C.I: ${c.cedula}'),
                      trailing: selected
                          ? const Icon(Icons.check_circle,
                              color: AppColors.primary)
                          : null,
                      onTap: () {
                        setState(() => _selectedCoordinatorId = c.id);
                      },
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // ── Recintos ─────────────────────────────────────────
                Text(
                  'Recintos electorales',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_precincts.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No hay recintos registrados.'),
                    ),
                  ),
                ..._precincts.map((p) {
                  final selected = _selectedPrecinctId == p.id;
                  final tieneCoord =
                      p.coordinadorRecintoId != null;
                  return Card(
                    color: selected
                        ? AppColors.primary.withOpacity(0.08)
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: selected
                          ? const BorderSide(
                              color: AppColors.primary, width: 2)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.provincialColor,
                        child: const Icon(Icons.location_city,
                            color: Colors.white, size: 20),
                      ),
                      title: Text(p.nombreRecinto,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${p.provincia} › ${p.canton} › ${p.parroquia}${tieneCoord ? '  •  Ya asignado' : '  •  Sin coordinador'}',
                        style: TextStyle(
                          color: tieneCoord
                              ? AppColors.success
                              : AppColors.textHint,
                        ),
                      ),
                      trailing: selected
                          ? const Icon(Icons.check_circle,
                              color: AppColors.primary)
                          : null,
                      onTap: () {
                        setState(() => _selectedPrecinctId = p.id);
                      },
                    ),
                  );
                }),

                const SizedBox(height: 32),

                // ── Botón ────────────────────────────────────────────
                ElevatedButton(
                  onPressed: _saving ? null : _assign,
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Asignar Coordinador'),
                ),
              ],
            ),
    );
  }
}
