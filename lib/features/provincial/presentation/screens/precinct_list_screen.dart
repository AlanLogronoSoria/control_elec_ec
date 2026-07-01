/// Pantalla de listado de recintos para el Coordinador Provincial.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/database/app_database.dart';


class PrecinctListScreen extends ConsumerStatefulWidget {
  const PrecinctListScreen({super.key});

  @override
  ConsumerState<PrecinctListScreen> createState() => _PrecinctListScreenState();
}

class _PrecinctListScreenState extends ConsumerState<PrecinctListScreen> {
  List<PrecinctsTableData> _precincts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final db = sl<AppDatabase>();
    final list = await db.precinctsDao.getAllPrecincts();
    if (mounted) {
      setState(() {
        _precincts = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recintos Electorales')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _precincts.isEmpty
                ? const Center(child: Text('No hay recintos registrados.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _precincts.length,
                    itemBuilder: (context, index) {
                      final p = _precincts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.provincialColor,
                            child: const Icon(Icons.location_city, color: Colors.white, size: 20),
                          ),
                          title: Text(p.nombreRecinto,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${p.provincia} › ${p.canton} › ${p.parroquia}'),
                          trailing: Text('JRV: ${p.numeroJrv}',
                              style: const TextStyle(color: AppColors.textHint)),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/provincial/crear-recinto'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Recinto'),
      ),
    );
  }
}
