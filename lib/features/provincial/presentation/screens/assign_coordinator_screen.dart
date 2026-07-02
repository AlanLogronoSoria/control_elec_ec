/// Pantalla para asignar un coordinador de recinto a un recinto electoral.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/provincial_entities.dart';
import '../providers/provincial_providers.dart';

class AssignCoordinatorScreen extends ConsumerStatefulWidget {
  const AssignCoordinatorScreen({super.key});

  @override
  ConsumerState<AssignCoordinatorScreen> createState() =>
      _AssignCoordinatorScreenState();
}

class _AssignCoordinatorScreenState
    extends ConsumerState<AssignCoordinatorScreen> {
  List<PrecinctCoordinatorEntity> _coordinators = [];
  List<AvanceRecintoEntity> _precincts = [];
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
    final coordsUseCase = ref.read(getCoordinadoresUseCaseProvider);
    final precsUseCase = ref.read(getAllPrecinctsUseCaseProvider);
    final coordsResult = await coordsUseCase();
    final precsResult = await precsUseCase();
    if (mounted) {
      setState(() {
        _coordinators = coordsResult.fold((_) => [], (l) => l);
        _precincts = precsResult.fold((_) => [], (l) => l);
        _loading = false;
      });
    }
  }

  Future<void> _assign() async {
    if (_selectedCoordinatorId == null || _selectedPrecinctId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un coordinador y un recinto.'), backgroundColor: AppColors.warning),
      );
      return;
    }
    setState(() => _saving = true);
    final useCase = ref.read(assignCoordinatorUseCaseProvider);
    final result = await useCase(
      precinctId: _selectedPrecinctId!,
      coordinatorId: _selectedCoordinatorId!,
    );
    if (mounted) {
      result.fold(
        (f) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(f.message), backgroundColor: AppColors.danger),
        ),
        (_) {
          final coord = _coordinators.firstWhere((c) => c.id == _selectedCoordinatorId);
          final prec = _precincts.firstWhere((p) => p.precinctId == _selectedPrecinctId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${coord.nombres} ${coord.apellidos} asignado a ${prec.precinctName}'),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        },
      );
      setState(() => _saving = false);
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
                Text('Coordinadores disponibles',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (_coordinators.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        const Icon(Icons.info_outline, color: AppColors.textHint),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('No hay coordinadores de recinto. Crea uno primero.')),
                        TextButton(onPressed: () => context.push('/provincial/crear-coordinador'), child: const Text('Crear')),
                      ]),
                    ),
                  ),
                ..._coordinators.map((c) {
                  final sel = _selectedCoordinatorId == c.id;
                  return Card(
                    color: sel ? AppColors.primary.withOpacity(0.08) : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: sel ? const BorderSide(color: AppColors.primary, width: 2) : BorderSide.none),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.recintoColor,
                        child: Text('${c.nombres[0]}${c.apellidos[0]}', style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text('${c.nombres} ${c.apellidos}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('C.I: ${c.cedula}'),
                      trailing: sel ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                      onTap: () => setState(() => _selectedCoordinatorId = c.id),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Text('Recintos electorales',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (_precincts.isEmpty)
                  const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No hay recintos registrados.'))),
                ..._precincts.map((p) {
                  final sel = _selectedPrecinctId == p.precinctId;
                  return Card(
                    color: sel ? AppColors.primary.withOpacity(0.08) : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: sel ? const BorderSide(color: AppColors.primary, width: 2) : BorderSide.none),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: AppColors.provincialColor,
                          child: const Icon(Icons.location_city, color: Colors.white, size: 20)),
                      title: Text(p.precinctName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${p.provincia} › ${p.canton} › ${p.parroquia}'),
                      trailing: sel ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                      onTap: () => setState(() => _selectedPrecinctId = p.precinctId),
                    ),
                  );
                }),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saving ? null : _assign,
                  child: _saving
                      ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                      : const Text('Asignar Coordinador'),
                ),
              ],
            ),
    );
  }
}
