/// Pantalla para que Coordinador de Recinto o Veedor corrijan un acta.
///
/// Permite editar votos, reemplazar foto y validar sumatoria.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../../../veedor/domain/entities/acta_entity.dart';
import '../../../veedor/domain/repositories/veedor_repository.dart';
import '../../../veedor/presentation/widgets/validation_summary.dart';

class ActCorrectionScreen extends ConsumerStatefulWidget {
  const ActCorrectionScreen({super.key, required this.actId});

  final String actId;

  @override
  ConsumerState<ActCorrectionScreen> createState() =>
      _ActCorrectionScreenState();
}

class _ActCorrectionScreenState extends ConsumerState<ActCorrectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _db = sl<AppDatabase>();
  final _repo = sl<VeedorRepository>();
  final _picker = ImagePicker();

  bool _loading = true;
  bool _saving = false;
  String? _errorMessage;

  ActsTableData? _actRow;
  List<OrganizacionFormEntity> _formFields = [];
  final Map<String, TextEditingController> _voteControllers = {};
  final _blancosController = TextEditingController();
  final _nulosController = TextEditingController();
  final _sufragantesController = TextEditingController();

  Uint8List? _newPhotoBytes;
  String? _newPhotoError;
  bool _analyzingPhoto = false;

  @override
  void dispose() {
    for (final c in _voteControllers.values) {
      c.dispose();
    }
    _blancosController.dispose();
    _nulosController.dispose();
    _sufragantesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final row = await _db.actsDao.getActById(widget.actId);
      if (row == null) {
        setState(() {
          _loading = false;
          _errorMessage = 'Acta no encontrada.';
        });
        return;
      }
      _actRow = row;

      final forms = await _db.actsDao.getOrganizationsByDignidad(row.tipoDignidad);
      final fields = <OrganizacionFormEntity>[];
      for (final org in forms) {
        final candidates =
            await _db.actsDao.getCandidatesByOrganization(org.id);
        if (candidates.isNotEmpty) {
          fields.add(OrganizacionFormEntity(
            organizationId: org.id,
            organizationName: org.nombre,
            candidateId: candidates.first.id,
            candidateName: candidates.first.nombre,
            colorHex: org.color,
          ));
        }
      }
      _formFields = fields;

      // Cargar votos existentes
      final existingVotes = await _db.actsDao.getVotesByAct(row.id);
      for (final field in fields) {
        final existing = existingVotes
            .where((v) => v.candidateId == field.candidateId)
            .firstOrNull;
        _voteControllers[field.candidateId] = TextEditingController(
          text: '${existing?.cantidadVotos ?? 0}',
        );
      }

      // Cargar extra votos
      final extras = await _db.actsDao.getExtraVotesByAct(row.id);
      _blancosController.text = '${extras?.votosBlancos ?? 0}';
      _nulosController.text = '${extras?.votosNulos ?? 0}';
      _sufragantesController.text = '${extras?.totalSufragantes ?? 0}';

      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = 'Error al cargar: $e';
      });
    }
  }

  Future<void> _captureNewPhoto() async {
    try {
      final photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (photo == null) return;

      setState(() => _analyzingPhoto = true);

      final bytes = await photo.readAsBytes();
      final blurResult = await _repo.isImageBlurry(bytes);

      blurResult.fold(
        (failure) {
          setState(() {
            _analyzingPhoto = false;
            _newPhotoError = 'Error al procesar la imagen. Intenta de nuevo.';
            _newPhotoBytes = null;
          });
        },
        (isBlurry) {
          setState(() {
            _analyzingPhoto = false;
            if (isBlurry) {
              _newPhotoError =
                  'Imagen borrosa. Asegúrate de enfocar bien el acta.';
              _newPhotoBytes = null;
            } else {
              _newPhotoError = null;
              _newPhotoBytes = bytes;
            }
          });
        },
      );
    } catch (e) {
      setState(() {
        _analyzingPhoto = false;
        _newPhotoError = 'Error de cámara: $e';
      });
    }
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_actRow == null) return;

    // Validar sumatoria
    final totalSufragantes =
        int.tryParse(_sufragantesController.text) ?? 0;
    final blancos = int.tryParse(_blancosController.text) ?? 0;
    final nulos = int.tryParse(_nulosController.text) ?? 0;

    int sumaCandidatos = 0;
    final votos = <VotoCandidatoEntity>[];
    for (final f in _formFields) {
      final cant =
          int.tryParse(_voteControllers[f.candidateId]?.text ?? '0') ?? 0;
      sumaCandidatos += cant;
      votos.add(VotoCandidatoEntity(
        candidateId: f.candidateId,
        candidateName: f.candidateName,
        organizationName: f.organizationName,
        cantidad: cant,
      ));
    }

    if ((sumaCandidatos + blancos + nulos) != totalSufragantes) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La suma de votos no coincide con el total de sufragantes.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _saving = true);

    final updatedActa = ActaElectoralEntity(
      id: _actRow!.id,
      tableId: _actRow!.tableId,
      tipoDignidad: _actRow!.tipoDignidad,
      votos: votos,
      votosBlancos: blancos,
      votosNulos: nulos,
      totalSufragantes: totalSufragantes,
      photoUrl: _actRow!.photoUrl,
      localPhotoPath: _actRow!.localPhotoPath,
      gpsLatitude: _actRow!.gpsLatitude,
      gpsLongitude: _actRow!.gpsLongitude,
    );

    final result = await _repo.correctActa(updatedActa,
        photoBytes: _newPhotoBytes);

    result.fold(
      (failure) {
        setState(() => _saving = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      },
      (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Acta corregida exitosamente.'),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        }
      },
    );
  }

  int get _totalCandidatos {
    int sum = 0;
    for (final f in _formFields) {
      sum += int.tryParse(_voteControllers[f.candidateId]?.text ?? '0') ?? 0;
    }
    return sum;
  }

  int get _blancos => int.tryParse(_blancosController.text) ?? 0;
  int get _nulos => int.tryParse(_nulosController.text) ?? 0;
  int get _sufragantes => int.tryParse(_sufragantesController.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Corregir Acta')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _load,
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // ── Cabecera ───────────────────────────────────
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: _actRow!.tipoDignidad == 'alcalde'
                                      ? AppColors.primary.withOpacity(0.1)
                                      : AppColors.accent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.description_outlined,
                                  color: _actRow!.tipoDignidad == 'alcalde'
                                      ? AppColors.primary
                                      : AppColors.accent,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _actRow!.tipoDignidad == 'alcalde'
                                          ? 'Acta de Alcalde'
                                          : 'Acta de Prefecto',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'ID: ${widget.actId.substring(0, 8)}...',
                                      style: const TextStyle(
                                          color: AppColors.textHint,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Total Sufragantes ──────────────────────────
                      TextFormField(
                        controller: _sufragantesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Total de Sufragantes',
                          prefixIcon: Icon(Icons.people_outline),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Votos por organización ─────────────────────
                      Text('Votos por Organización',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ..._formFields.map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        '0xFF${f.colorHex.replaceAll('#', '')}')),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(f.organizationName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13)),
                                      Text(f.candidateName,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.textHint)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: TextFormField(
                                    controller:
                                        _voteControllers[f.candidateId],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _blancosController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Votos Blancos',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _nulosController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Votos Nulos',
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ── Validación ──────────────────────────────────
                      ValidationSummary(
                        totalVotosCandidatos: _totalCandidatos,
                        votosBlancos: _blancos,
                        votosNulos: _nulos,
                        totalSufragantes: _sufragantes,
                      ),

                      const SizedBox(height: 20),

                      // ── Foto ────────────────────────────────────────
                      Text('Fotografía del Acta',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (_actRow!.localPhotoPath != null ||
                          _actRow!.photoUrl != null ||
                          _newPhotoBytes != null)
                        Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              if (_newPhotoBytes != null)
                                Image.memory(_newPhotoBytes!,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover)
                              else if (_actRow!.localPhotoPath != null)
                                Image.file(
                                  File(_actRow!.localPhotoPath!),
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 120,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Text('Imagen no disponible'),
                                    ),
                                  ),
                                )
                              else if (_actRow!.photoUrl != null)
                                Image.network(
                                  _actRow!.photoUrl!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 120,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Text('Imagen no disponible'),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: _newPhotoBytes != null
                                    ? Row(
                                        children: [
                                          const Icon(Icons.check_circle,
                                              color: AppColors.success,
                                              size: 18),
                                          const SizedBox(width: 8),
                                          const Expanded(
                                            child: Text('Nueva foto lista',
                                                style: TextStyle(
                                                    color: AppColors.success))),
                                          TextButton(
                                            onPressed: () => setState(
                                                () => _newPhotoBytes = null),
                                            child: const Text('Descartar'),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      if (_newPhotoError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(_newPhotoError!,
                              style: const TextStyle(
                                  color: AppColors.danger, fontSize: 12)),
                        ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: _analyzingPhoto ? null : _captureNewPhoto,
                        icon: _analyzingPhoto
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : const Icon(Icons.camera_alt),
                        label: Text(_newPhotoBytes != null
                            ? 'Reemplazar Foto'
                            : 'Capturar Nueva Foto'),
                      ),

                      const SizedBox(height: 32),

                      // ── Botón Guardar ──────────────────────────────
                      ElevatedButton(
                        onPressed: _saving ? null : _save,
                        child: _saving
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5, color: Colors.white))
                            : const Text('Guardar Corrección'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
