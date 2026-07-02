/// Servicio de sincronización offline → Appwrite.
///
/// Implementa el patrón Transactional Outbox:
/// - Monitorea conectividad con connectivity_plus
/// - Procesa la offline_queue en orden FIFO cuando hay red
/// - Maneja reintentos con backoff exponencial
/// - Resolución de conflictos: Last-Write-Wins via updated_at
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:logger/logger.dart';

import '../constants/app_constants.dart';
import '../database/app_database.dart';
import '../network/network_info.dart';
import 'appwrite_service.dart';

/// Servicio de sincronización bidireccional offline ↔ Appwrite.
class SyncService {
  SyncService({
    required AppDatabase database,
    required NetworkInfo networkInfo,
  })  : _db = database,
        _networkInfo = networkInfo;

  final AppDatabase _db;
  final NetworkInfo _networkInfo;
  final _logger = Logger();

  /// Timer de sincronización periódica.
  Timer? _syncTimer;

  /// Suscripción a cambios de conectividad.
  StreamSubscription<bool>? _connectivitySubscription;

  /// Si hay una sincronización en progreso.
  bool _isSyncing = false;

  /// Número de operaciones pendientes (expuesto para UI).
  final StreamController<int> _pendingCountController =
      StreamController<int>.broadcast();

  Stream<int> get pendingCountStream => _pendingCountController.stream;

  // ── Ciclo de vida ─────────────────────────────────────────────────────

  /// Inicia el servicio de sincronización.
  /// Llama en el inicio de la app (WidgetsBinding.addPostFrameCallback).
  void start() {
    _logger.i('[SyncService] Iniciando...');

    // 1. Escuchar cambios de conectividad
    _connectivitySubscription =
        _networkInfo.connectivityStream.listen((isConnected) {
      if (isConnected) {
        _logger.i('[SyncService] Conexión restaurada. Sincronizando...');
        _processQueue();
      }
    });

    // 2. Sincronización periódica cada 30 segundos
    _syncTimer = Timer.periodic(AppConstants.syncInterval, (_) async {
      final isConnected = await _networkInfo.isConnected;
      if (isConnected) _processQueue();
    });

    // 3. Observar cambios en la cola para actualizar el contador
    _db.offlineQueueDao.watchPendingCount().listen((count) {
      _pendingCountController.add(count);
    });

    // 4. Intentar sincronizar al iniciar
    _networkInfo.isConnected.then((connected) {
      if (connected) _processQueue();
    });
  }

  /// Detiene el servicio de sincronización.
  void stop() {
    _syncTimer?.cancel();
    _connectivitySubscription?.cancel();
    _pendingCountController.close();
    _logger.i('[SyncService] Detenido.');
  }

  // ── Procesamiento de la cola ───────────────────────────────────────────

  /// Procesa todos los ítems pendientes en la cola (FIFO).
  Future<void> _processQueue() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pending = await _db.offlineQueueDao.getPendingOperations();
      _logger.d('[SyncService] Procesando ${pending.length} operaciones pendientes.');

      for (final item in pending) {
        await _processItem(item);
      }

      // Limpiar entradas viejas
      await _db.offlineQueueDao.cleanup();
    } catch (e) {
      _logger.e('[SyncService] Error procesando cola: $e');
    } finally {
      _isSyncing = false;
    }
  }

  /// Procesa un único ítem de la cola.
  Future<void> _processItem(OfflineQueueTableData item) async {
    // Máximo 5 reintentos
    if (item.retryCount >= 5) {
      await _db.offlineQueueDao.markFailed(
        item.id,
        'Máximo de reintentos alcanzado.',
      );
      return;
    }

    await _db.offlineQueueDao.markProcessing(item.id);

    try {
      final rawPayload = jsonDecode(item.payload) as Map<String, dynamic>;
      final data = (rawPayload['_data'] as Map<String, dynamic>?) ??
          (rawPayload['data'] as Map<String, dynamic>?) ??
          rawPayload;
      final permissions = (rawPayload['_permissions'] as List?)
              ?.map((p) => p.toString())
              .toList() ??
          (rawPayload['permissions'] as List?)?.map((p) => p.toString()).toList();

      switch (item.operation) {
        case 'create':
          await _handleCreate(item, data, permissions);
        case 'update':
          await _handleUpdate(item, data, permissions);
        case 'delete':
          await _handleDelete(item, permissions);
        case 'file_upload':
          await _handleFileUpload(item, rawPayload);
      }

      await _db.offlineQueueDao.markSynced(item.id);
      _logger.d('[SyncService] ✓ Sincronizado: ${item.operation} ${item.documentId}');
    } on AppwriteException catch (e) {
      await _handleAppwriteError(item, e);
    } catch (e) {
      await _db.offlineQueueDao.scheduleRetry(item.id, item.retryCount);
      _logger.w('[SyncService] ✗ Error en ${item.documentId}: $e');
    }
  }

  // ── Handlers por operación ────────────────────────────────────────────

  Future<void> _handleCreate(
    OfflineQueueTableData item,
    Map<String, dynamic> data,
    List<String>? permissions,
  ) async {
    await AppwriteService.instance.databases.createDocument(
      databaseId: AppConstants.appwriteDatabaseId,
      collectionId: item.collectionName,
      documentId: item.documentId,
      data: data,
      permissions: permissions,
    );
  }

  Future<void> _handleUpdate(
    OfflineQueueTableData item,
    Map<String, dynamic> data,
    List<String>? permissions,
  ) async {
    bool serverDocReadable = true;
    dynamic serverDoc;
    try {
      serverDoc = await AppwriteService.instance.databases.getDocument(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: item.collectionName,
        documentId: item.documentId,
      );
    } on AppwriteException catch (e) {
      if (e.code == 401 || e.code == 403) {
        serverDocReadable = false;
      } else if (e.code == 404) {
        serverDocReadable = false;
      } else {
        rethrow;
      }
    }

    try {
      if (serverDocReadable && serverDoc != null) {
        final serverUpdatedAt = DateTime.tryParse(
          serverDoc.data['updated_at']?.toString() ?? '',
        );
        final localUpdatedAt = DateTime.tryParse(
          data['updated_at']?.toString() ?? '',
        );

        if (serverUpdatedAt != null &&
            localUpdatedAt != null &&
            serverUpdatedAt.isAfter(localUpdatedAt)) {
          _logger.w(
            '[SyncService] Conflicto: servidor más reciente para ${item.documentId}. '
            'Descartando cambio local.',
          );
          await _db.offlineQueueDao.markSynced(item.id);
          return;
        }
      }

      await AppwriteService.instance.databases.updateDocument(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: item.collectionName,
        documentId: item.documentId,
        data: data,
        permissions: permissions,
      );
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        await _handleCreate(item, data, permissions);
      } else {
        rethrow;
      }
    }
  }

  Future<void> _handleDelete(
      OfflineQueueTableData item, List<String>? permissions) async {
    try {
      await AppwriteService.instance.databases.deleteDocument(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: item.collectionName,
        documentId: item.documentId,
      );
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        // Ya no existe → ok
        return;
      }
      rethrow;
    }
  }

  Future<void> _handleAppwriteError(
    OfflineQueueTableData item,
    AppwriteException e,
  ) async {
    if (e.code == 409) {
      // Conflicto de duplicado → documento ya existe
      _logger.w('[SyncService] Duplicado detectado para ${item.documentId}. Marcando como sincronizado.');
      await _db.offlineQueueDao.markSynced(item.id);
    } else if (e.code == 401 || e.code == 403) {
      // Sin permisos → marcar como fallido permanentemente
      await _db.offlineQueueDao.markFailed(item.id, 'Sin permisos: ${e.message}');
    } else {
      await _db.offlineQueueDao.scheduleRetry(item.id, item.retryCount);
      _logger.w('[SyncService] Appwrite error ${e.code}: ${e.message}');
    }
  }

  // ── Handler de archivos ───────────────────────────────────────────────

  /// Sube una foto pendiente a Appwrite Storage y actualiza el acta local.
  Future<void> _handleFileUpload(
    OfflineQueueTableData item,
    Map<String, dynamic> payload,
  ) async {
    final localPath = payload['local_path'] as String;
    final actId = payload['act_id'] as String;
    final fileId = item.documentId;
    final file = File(localPath);

    if (!await file.exists()) {
      await _db.offlineQueueDao.markFailed(
        item.id,
        'Archivo local no encontrado: $localPath',
      );
      return;
    }

    final rawPerms = payload['_permissions'];
    final permissions = rawPerms is List ? rawPerms.cast<String>() : null;

    final uploaded = await AppwriteService.instance.storage.createFile(
      bucketId: AppConstants.storageActsBucketId,
      fileId: fileId,
      file: InputFile.fromPath(
        path: localPath,
        filename: 'acta_$fileId.jpg',
      ),
      permissions: permissions,
    );

    final photoUrl = '${AppConstants.appwriteEndpoint}/storage/buckets/'
        '${AppConstants.storageActsBucketId}/files/'
        '${uploaded.$id}/view?project=${AppConstants.appwriteProjectId}';

    // Actualizar photoUrl en la base de datos local
    await _db.actsDao.updateActPhoto(actId, photoUrl);

    _logger.i('[SyncService] ✓ Foto subida: actId=$actId, fileId=${uploaded.$id}');
  }

  // ── API pública ───────────────────────────────────────────────────────

  /// Fuerza una sincronización inmediata.
  Future<void> syncNow() async {
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      await _processQueue();
    }
  }

  /// Encola una operación de creación.
  Future<void> enqueueCreate({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> payload,
    List<String>? permissions,
  }) async {
    final wrappedPayload = <String, dynamic>{
      '_data': payload,
      if (permissions != null) '_permissions': permissions,
    };
    await _db.offlineQueueDao.enqueue(
      operation: 'create',
      collectionName: collectionName,
      documentId: documentId,
      payload: jsonEncode(wrappedPayload),
    );
  }

  /// Encola una operación de actualización.
  Future<void> enqueueUpdate({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> payload,
    List<String>? permissions,
  }) async {
    final wrappedPayload = <String, dynamic>{
      '_data': payload,
      if (permissions != null) '_permissions': permissions,
    };
    await _db.offlineQueueDao.enqueue(
      operation: 'update',
      collectionName: collectionName,
      documentId: documentId,
      payload: jsonEncode(wrappedPayload),
    );
  }

  /// Encola una operación de eliminación.
  Future<void> enqueueDelete({
    required String collectionName,
    required String documentId,
    List<String>? permissions,
  }) async {
    final wrappedPayload = <String, dynamic>{
      '_data': <String, dynamic>{},
      if (permissions != null) '_permissions': permissions,
    };
    await _db.offlineQueueDao.enqueue(
      operation: 'delete',
      collectionName: collectionName,
      documentId: documentId,
      payload: jsonEncode(wrappedPayload),
    );
  }

  /// Encola una subida de foto pendiente para sincronización offline.
  /// Se procesa cuando se recupera la conectividad.
  Future<void> enqueueFileUpload({
    required String actId,
    required String fileId,
    required String localPath,
    List<String>? permissions,
  }) async {
    await _db.offlineQueueDao.enqueue(
      operation: 'file_upload',
      collectionName: AppConstants.storageActsBucketId,
      documentId: fileId,
      payload: jsonEncode({
        'act_id': actId,
        'local_path': localPath,
        if (permissions != null) '_permissions': permissions,
      }),
    );
  }
}
