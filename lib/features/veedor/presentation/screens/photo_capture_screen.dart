/// Pantalla para captura de fotos de actas electorales con detección de desenfoque.
library;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/veedor_providers.dart';

class PhotoCaptureScreen extends ConsumerStatefulWidget {
  const PhotoCaptureScreen({
    super.key,
    required this.dignidad,
    required this.onPhotoAccepted,
  });

  final String dignidad;
  final Function(Uint8List photoBytes) onPhotoAccepted;

  @override
  ConsumerState<PhotoCaptureScreen> createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends ConsumerState<PhotoCaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  bool _isProcessing = false;
  bool _isBlurry = false;
  String? _errorMessage;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo == null) return;

      setState(() {
        _isProcessing = true;
        _errorMessage = null;
      });

      final bytes = await photo.readAsBytes();
      final repo = ref.read(veedorRepositoryProvider);
      
      // Analizar desenfoque
      final blurResult = await repo.isImageBlurry(bytes);

      blurResult.fold(
        (failure) {
          setState(() {
            _isProcessing = false;
            _isBlurry = true;
            _errorMessage = 'Error al procesar la imagen. Intenta de nuevo con mejor iluminación.';
            _imageBytes = bytes;
          });
        },
        (isBlurry) {
          setState(() {
            _isProcessing = false;
            _isBlurry = isBlurry;
            _imageBytes = bytes;
            if (isBlurry) {
              _errorMessage = 'La imagen está borrosa. Asegúrate de enfocar bien el acta y que haya buena iluminación.';
            }
          });
        },
      );
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Error al procesar la imagen: $e';
      });
    }
  }

  void _acceptPhoto() {
    if (_imageBytes != null && !_isBlurry) {
      widget.onPhotoAccepted(_imageBytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acta: ${widget.dignidad.toUpperCase()}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Instrucciones ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary.withOpacity(0.1),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Toma una foto clara y legible de toda el acta. Evita reflejos y sombras excesivas.',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),

            // ── Previsualización ──────────────────────────────────────
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isBlurry ? AppColors.danger : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      if (_imageBytes != null)
                        Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                        )
                      else
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Ninguna foto capturada', style: TextStyle(color: Colors.grey)),
                          ],
                        ),

                      if (_isProcessing)
                        Container(
                          color: Colors.black54,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 16),
                              Text('Analizando nitidez...', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Mensajes de error ─────────────────────────────────────
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.danger),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Botones de acción ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isProcessing ? null : _takePhoto,
                      icon: const Icon(Icons.camera_alt),
                      label: Text(_imageBytes == null ? 'Tomar Foto' : 'Reintentar'),
                    ),
                  ),
                  if (_imageBytes != null && !_isBlurry) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _acceptPhoto,
                        icon: const Icon(Icons.check),
                        label: const Text('Continuar'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
