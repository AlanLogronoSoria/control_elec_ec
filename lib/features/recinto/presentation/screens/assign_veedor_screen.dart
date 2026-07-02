/// Pantalla para asignar una mesa a un veedor.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/recinto_entities.dart';
import '../providers/recinto_providers.dart';

class AssignVeedorScreen extends ConsumerStatefulWidget {
  const AssignVeedorScreen({
    super.key,
    required this.tableId,
    required this.tableNumber,
  });

  final String tableId;
  final int tableNumber;

  @override
  ConsumerState<AssignVeedorScreen> createState() => _AssignVeedorScreenState();
}

class _AssignVeedorScreenState extends ConsumerState<AssignVeedorScreen> {
  List<VeedorAsignadoEntity> _veedores = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadVeedores();
  }

  Future<void> _loadVeedores() async {
    setState(() => _loading = true);
    final useCase = ref.read(getVeedoresUseCaseProvider);
    final result = await useCase();
    result.fold(
      (_) {},
      (veedores) {
        if (mounted) setState(() => _veedores = veedores);
      },
    );
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _assign(String veedorId) async {
    final useCase = ref.read(assignTableUseCaseProvider);
    final result = await useCase(tableId: widget.tableId, veedorId: veedorId);
    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message), backgroundColor: AppColors.danger),
          );
        }
      },
      (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mesa asignada exitosamente'), backgroundColor: AppColors.success),
          );
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asignar JRV #${widget.tableNumber}')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _veedores.isEmpty
              ? const Center(child: Text('No hay veedores disponibles.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _veedores.length,
                  itemBuilder: (context, index) {
                    final v = _veedores[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.recintoColor,
                          child: Text(
                            '${v.user.nombres[0]}${v.user.apellidos[0]}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text('${v.user.nombres} ${v.user.apellidos}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('C.I: ${v.user.cedula}'),
                            Text('Mesas: ${v.mesasAsignadas.join(", ")}'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _assign(v.user.id),
                          child: const Text('Asignar'),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
