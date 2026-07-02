/// Pantalla de detalle de acta para el Coordinador Provincial (solo lectura).
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/provincial_entities.dart';
import '../providers/provincial_providers.dart';

class ProvincialActDetailScreen extends ConsumerStatefulWidget {
  const ProvincialActDetailScreen({super.key, required this.actId});

  final String actId;

  @override
  ConsumerState<ProvincialActDetailScreen> createState() =>
      _ProvincialActDetailScreenState();
}

class _ProvincialActDetailScreenState
    extends ConsumerState<ProvincialActDetailScreen> {
  bool _loading = true;
  String? _error;
  ProvincialActaDetailEntity? _acta;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final useCase = ref.read(getActaDetailUseCaseProvider);
    final result = await useCase(widget.actId);
    result.fold(
      (l) {
        if (mounted) {
          setState(() {
            _error = l.message;
            _loading = false;
          });
        }
      },
      (r) {
        if (mounted) {
          setState(() {
            _acta = r;
            _loading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Acta')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: AppColors.danger, size: 48),
                      const SizedBox(height: 16),
                      Text(_error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.danger)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _load,
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    final acta = _acta!;
    final fmt = DateFormat('dd/MM/yyyy HH:mm');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderCard(acta: acta),
          const SizedBox(height: 16),
          _GpsCard(acta: acta),
          const SizedBox(height: 16),
          _PhotoCard(acta: acta),
          const SizedBox(height: 16),
          _VotesCard(acta: acta),
          const SizedBox(height: 16),
          _RegistryInfoCard(acta: acta, fmt: fmt),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.acta});
  final ProvincialActaDetailEntity acta;

  @override
  Widget build(BuildContext context) {
    final isAlcalde = acta.tipoDignidad == 'alcalde';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: isAlcalde
                ? [AppColors.primary, AppColors.primaryDark]
                : [AppColors.accent, const Color(0xFF6A1B9A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isAlcalde ? Icons.account_balance : Icons.domain,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAlcalde ? 'Acta de Alcalde' : 'Acta de Prefecto',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${acta.precinctName} — JRV #${acta.mesaJrv}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: acta.estado == 'sincronizado'
                        ? AppColors.success.withOpacity(0.3)
                        : AppColors.warning.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    acta.estado == 'sincronizado'
                        ? 'Sincronizada'
                        : 'Guardada',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GpsCard extends StatelessWidget {
  const _GpsCard({required this.acta});
  final ProvincialActaDetailEntity acta;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.gps_fixed, color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                const Text('Coordenadas GPS',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            if (acta.gpsLatitude != null && acta.gpsLongitude != null) ...[
              _infoRow('Latitud', acta.gpsLatitude!.toStringAsFixed(6)),
              _infoRow('Longitud', acta.gpsLongitude!.toStringAsFixed(6)),
            ] else
              const Text('Sin coordenadas registradas.',
                  style: TextStyle(color: AppColors.textHint)),
          ],
        ),
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({required this.acta});
  final ProvincialActaDetailEntity acta;

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        acta.photoUrl != null || acta.localPhotoPath != null;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.camera_alt, color: AppColors.primary, size: 18),
                SizedBox(width: 8),
                Text('Fotografía del Acta',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            if (hasPhoto)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: acta.photoUrl != null
                    ? Image.network(
                        acta.photoUrl!,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _noImagePlaceholder(),
                      )
                    : acta.localPhotoPath != null
                        ? Image.file(
                            File(acta.localPhotoPath!),
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _noImagePlaceholder(),
                          )
                        : _noImagePlaceholder(),
              )
            else
              _noImagePlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _noImagePlaceholder() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, color: Colors.grey, size: 32),
            SizedBox(height: 8),
            Text('Sin fotografía', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _VotesCard extends StatelessWidget {
  const _VotesCard({required this.acta});
  final ProvincialActaDetailEntity acta;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.how_to_vote,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      const Text('Votos Registrados',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      const Spacer(),
                      Icon(
                        acta.sumatoriaValida
                            ? Icons.check_circle
                            : Icons.warning,
                        size: 16,
                        color: acta.sumatoriaValida
                            ? AppColors.success
                            : AppColors.danger,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        acta.sumatoriaValida
                            ? 'Suma correcta'
                            : 'Suma incorrecta',
                        style: TextStyle(
                          fontSize: 11,
                          color: acta.sumatoriaValida
                              ? AppColors.success
                              : AppColors.danger,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Total Sufragantes: ${acta.totalSufragantes}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            ...acta.votos.map((v) {
              final hex = v.colorHex.replaceAll('#', '');
              final colorVal = int.tryParse(hex, radix: 16) ?? 0xFF888888;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Color(colorVal | 0xFF000000),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(v.organizationName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(v.candidateName,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textHint)),
                        ],
                      ),
                    ),
                    Text('${v.cantidad}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            _infoRow('Votos Blancos', '${acta.votosBlancos}'),
            _infoRow('Votos Nulos', '${acta.votosNulos}'),
          ],
        ),
      ),
    );
  }
}

class _RegistryInfoCard extends StatelessWidget {
  const _RegistryInfoCard({required this.acta, required this.fmt});
  final ProvincialActaDetailEntity acta;
  final DateFormat fmt;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary, size: 18),
                SizedBox(width: 8),
                Text('Información de Registro',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow('Creado', fmt.format(acta.createdAt)),
            _infoRow('Última modificación', fmt.format(acta.updatedAt)),
            if (acta.veedorNombre != null) ...[
              const Divider(height: 16),
              _infoRow('Veedor', acta.veedorNombre!),
              _infoRow('Cédula', acta.veedorCedula ?? '—'),
            ],
          ],
        ),
      ),
    );
  }
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.textHint, fontSize: 13)),
        Flexible(
          child: Text(value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              textAlign: TextAlign.end),
        ),
      ],
    ),
  );
}
