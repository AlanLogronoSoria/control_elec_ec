/// Pantalla de detalle de un acta electoral.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/acta_entity.dart';
import '../providers/veedor_providers.dart';

class ActDetailScreen extends ConsumerStatefulWidget {
  const ActDetailScreen({super.key, required this.actId, required this.tableId});

  final String actId;
  final String tableId;

  @override
  ConsumerState<ActDetailScreen> createState() => _ActDetailScreenState();
}

class _ActDetailScreenState extends ConsumerState<ActDetailScreen> {
  ActaElectoralEntity? _acta;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(veedorRepositoryProvider);
    final result = await repo.getActa(widget.tableId, 'alcalde');
    result.fold(
      (_) {},
      (acta) {
        if (mounted) setState(() {
          _acta = acta;
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Acta')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _acta == null
              ? const Center(child: Text('Acta no encontrada'))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dignidad: ${_acta!.tipoDignidad}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const Divider(),
                            if (_acta!.photoUrl != null) ...[
                              const Text('Foto del acta:'),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(_acta!.photoUrl!, height: 200, fit: BoxFit.cover),
                              ),
                            ],
                            const SizedBox(height: 16),
                            Text('GPS: ${_acta!.gpsLatitude}, ${_acta!.gpsLongitude}'),
                            Text('Total Sufragantes: ${_acta!.totalSufragantes}'),
                            Text('Votos Blancos: ${_acta!.votosBlancos}'),
                            Text('Votos Nulos: ${_acta!.votosNulos}'),
                            const Divider(),
                            const Text('Votos por Candidato:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ..._acta!.votos.map((v) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(v.organizationName)),
                                      Text('${v.cantidad}',
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
