/// Asistente de registro de un acta electoral.
///
/// Flujo:
/// 1. Seleccionar Dignidad.
/// 2. Capturar Foto (y verificar desenfoque).
/// 3. Obtener ubicación GPS.
/// 4. Llenar resultados (votos).
/// 5. Validar sumas y guardar.
library;

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/services/gps_service.dart';
import '../../domain/entities/acta_entity.dart';
import '../../domain/repositories/veedor_repository.dart';
import '../providers/veedor_providers.dart';
import 'photo_capture_screen.dart';

class ActRegistrationScreen extends ConsumerStatefulWidget {
  const ActRegistrationScreen({
    super.key,
    required this.tableId,
  });

  final String tableId;

  @override
  ConsumerState<ActRegistrationScreen> createState() => _ActRegistrationScreenState();
}

class _ActRegistrationScreenState extends ConsumerState<ActRegistrationScreen> {
  int _currentStep = 0;
  String _selectedDignidad = 'alcalde'; // o 'prefecto'
  
  Uint8List? _photoBytes;
  double? _gpsLatitude;
  double? _gpsLongitude;
  
  List<OrganizacionFormEntity> _formFields = [];
  final Map<String, TextEditingController> _voteControllers = {};
  final TextEditingController _votosBlancosController = TextEditingController(text: '0');
  final TextEditingController _votosNulosController = TextEditingController(text: '0');
  final TextEditingController _totalSufragantesController = TextEditingController();

  bool _isLoadingForm = false;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    for (final controller in _voteControllers.values) {
      controller.dispose();
    }
    _votosBlancosController.dispose();
    _votosNulosController.dispose();
    _totalSufragantesController.dispose();
    super.dispose();
  }

  // ── Handlers ──────────────────────────────────────────────────────────

  Future<void> _loadFormForDignidad() async {
    setState(() {
      _isLoadingForm = true;
      _errorMessage = null;
    });

    final repo = sl<VeedorRepository>();
    final result = await repo.getFormularioForDignidad(_selectedDignidad);

    result.fold(
      (failure) {
        setState(() {
          _errorMessage = failure.message;
          _isLoadingForm = false;
        });
      },
      (forms) {
        setState(() {
          _formFields = forms;
          _voteControllers.clear();
          for (final f in forms) {
            _voteControllers[f.candidateId] = TextEditingController(text: '0');
          }
          _isLoadingForm = false;
        });
      },
    );
  }

  Future<void> _captureGps() async {
    try {
      final gps = sl<GpsService>();
      final position = await gps.getCurrentPosition();
      setState(() {
        _gpsLatitude = position.latitude;
        _gpsLongitude = position.longitude;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'No se pudo obtener el GPS: $e';
      });
    }
  }

  Future<void> _saveActa() async {
    setState(() => _isSaving = true);
    
    try {
      final totalSufragantes = int.tryParse(_totalSufragantesController.text) ?? 0;
      final votosBlancos = int.tryParse(_votosBlancosController.text) ?? 0;
      final votosNulos = int.tryParse(_votosNulosController.text) ?? 0;
      
      final votosList = <VotoCandidatoEntity>[];
      for (final f in _formFields) {
        final cant = int.tryParse(_voteControllers[f.candidateId]?.text ?? '0') ?? 0;
        votosList.add(
          VotoCandidatoEntity(
            candidateId: f.candidateId,
            candidateName: f.candidateName,
            organizationName: f.organizationName,
            cantidad: cant,
          ),
        );
      }

      final result = await ref.read(registerActaUseCaseProvider).call(
        tableId: widget.tableId,
        tipoDignidad: _selectedDignidad,
        votos: votosList,
        votosBlancos: votosBlancos,
        votosNulos: votosNulos,
        totalSufragantes: totalSufragantes,
        photoBytes: _photoBytes!,
        gpsLatitude: _gpsLatitude ?? 0.0,
        gpsLongitude: _gpsLongitude ?? 0.0,
      );

      result.fold(
        (failure) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message), backgroundColor: AppColors.danger),
          );
          setState(() => _isSaving = false);
        },
        (_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Acta guardada exitosamente'), backgroundColor: AppColors.success),
          );
          ref.read(tablesProvider.notifier).loadTables();
          context.pop();
        },
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $e'), backgroundColor: AppColors.danger),
      );
      setState(() => _isSaving = false);
    }
  }

  // ── Steps UI ──────────────────────────────────────────────────────────

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('Dignidad'),
        content: DropdownButtonFormField<String>(
          initialValue: _selectedDignidad,
          decoration: const InputDecoration(labelText: 'Seleccione Dignidad'),
          items: const [
            DropdownMenuItem(value: 'alcalde', child: Text('Alcalde')),
            DropdownMenuItem(value: 'prefecto', child: Text('Prefecto')),
          ],
          onChanged: (val) {
            if (val != null) {
              setState(() => _selectedDignidad = val);
            }
          },
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Foto & GPS'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_photoBytes == null)
              ElevatedButton.icon(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PhotoCaptureScreen(
                        dignidad: _selectedDignidad,
                        onPhotoAccepted: (bytes) {
                          setState(() => _photoBytes = bytes);
                          Navigator.pop(context);
                          _captureGps(); // Auto capturar GPS al aceptar foto
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar Foto del Acta'),
              )
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.success),
                      const SizedBox(width: 8),
                      const Expanded(child: Text('Foto verificada y guardada temporalmente.')),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => setState(() => _photoBytes = null),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            if (_gpsLatitude != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.gps_fixed, color: AppColors.success),
                      const SizedBox(width: 8),
                      Expanded(child: Text('GPS: $_gpsLatitude, $_gpsLongitude')),
                    ],
                  ),
                ),
              )
            else
              OutlinedButton.icon(
                onPressed: _captureGps,
                icon: const Icon(Icons.location_on),
                label: const Text('Obtener Ubicación Actual'),
              ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(_errorMessage!, style: const TextStyle(color: AppColors.danger)),
            ]
          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Resultados'),
        content: _isLoadingForm
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextFormField(
                    controller: _totalSufragantesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total de Sufragantes',
                      helperText: 'Firma(s) y huella(s) dactilar(es)',
                    ),
                  ),
                  const Divider(height: 32),
                  ..._formFields.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(f.organizationName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(f.candidateName, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _voteControllers[f.candidateId],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 8)),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const Divider(height: 32),
                  Row(
                    children: [
                      Expanded(child: TextFormField(controller: _votosBlancosController, decoration: const InputDecoration(labelText: 'Blancos'), keyboardType: TextInputType.number)),
                      const SizedBox(width: 16),
                      Expanded(child: TextFormField(controller: _votosNulosController, decoration: const InputDecoration(labelText: 'Nulos'), keyboardType: TextInputType.number)),
                    ],
                  ),
                ],
              ),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Acta')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            _loadFormForDignidad();
            setState(() => _currentStep++);
          } else if (_currentStep == 1) {
            if (_photoBytes == null || _gpsLatitude == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Debe capturar la foto y el GPS')),
              );
              return;
            }
            setState(() => _currentStep++);
          } else if (_currentStep == 2) {
            _saveActa();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          final isLastStep = _currentStep == 2;
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : details.onStepContinue,
                    child: _isSaving
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(isLastStep ? 'Validar y Guardar' : 'Continuar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSaving ? null : details.onStepCancel,
                    child: const Text('Atrás'),
                  ),
                ),
              ],
            ),
          );
        },
        steps: _buildSteps(),
      ),
    );
  }
}
