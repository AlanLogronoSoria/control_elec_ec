/// Pantalla de listado de mesas electorales para el Coordinador de Recinto.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/database/app_database.dart';

class TableListScreen extends ConsumerStatefulWidget {
  const TableListScreen({super.key, required this.precinctId});

  final String precinctId;

  @override
  ConsumerState<TableListScreen> createState() => _TableListScreenState();
}

class _TableListScreenState extends ConsumerState<TableListScreen> {
  List<ElectoralTablesTableData> _tables = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    setState(() => _loading = true);
    final db = sl<AppDatabase>();
    final tables = await db.precinctsDao.getTablesByPrecinct(widget.precinctId);
    if (mounted) {
      setState(() {
        _tables = tables;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mesas del Recinto')),
      body: RefreshIndicator(
        onRefresh: _loadTables,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _tables.isEmpty
                ? const Center(child: Text('No hay mesas registradas.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tables.length,
                    itemBuilder: (context, index) {
                      final table = _tables[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryLight,
                            child: Text('${table.jrvNumber}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text('JRV #${table.jrvNumber}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Estado: ${table.estadoActa}'),
                          trailing: Chip(
                            label: Text(
                              table.veedorId != null ? 'Asignada' : 'Sin veedor',
                              style: const TextStyle(fontSize: 11),
                            ),
                            backgroundColor: table.veedorId != null
                                ? AppColors.successLight.withOpacity(0.2)
                                : AppColors.warningLight.withOpacity(0.2),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
