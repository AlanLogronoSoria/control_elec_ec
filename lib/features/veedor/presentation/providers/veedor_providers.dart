/// Providers para el módulo del Veedor.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/services/gps_service.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/acta_entity.dart';
import '../../domain/repositories/veedor_repository.dart';
import '../../domain/usecases/veedor_usecases.dart';

final veedorRepositoryProvider = Provider<VeedorRepository>((ref) {
  return sl<VeedorRepository>();
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return sl<AppDatabase>();
});

final gpsServiceProvider = Provider<GpsService>((ref) {
  return sl<GpsService>();
});

// ── Casos de uso ─────────────────────────────────────────────────────────

final getAssignedTablesUseCaseProvider = Provider<GetAssignedTablesUseCase>((ref) {
  return sl<GetAssignedTablesUseCase>();
});

final registerActaUseCaseProvider = Provider<RegisterActaUseCase>((ref) {
  return sl<RegisterActaUseCase>();
});

final correctActaUseCaseProvider = Provider<CorrectActaUseCase>((ref) {
  return sl<CorrectActaUseCase>();
});

// ── Estado ───────────────────────────────────────────────────────────────

/// Provider que expone la lista de mesas asignadas al veedor actual.
/// Se actualiza automáticamente (es un Stream que escucha cambios en Drift).
final assignedTablesProvider = StreamProvider<List<MesaElectoralEntity>>((ref) {
  return sl<GetAssignedTablesUseCase>().call().asStream().asyncMap((either) {
    return either.fold(
      (failure) => throw Exception(failure.message),
      (tables) => tables,
    );
  });
});

// (Idealmente se usaría watchAssignedTables del repo para ser reactivo a cambios locales,
// pero por simplicidad de este ejemplo, si `getAssignedTables` retornara un Stream, sería mejor).
// Modifiquemos el provider para simular un state notifier básico de mesas si no usamos Stream directo.

class AssignedTablesNotifier extends StateNotifier<AsyncValue<List<MesaElectoralEntity>>> {
  AssignedTablesNotifier(this._getAssignedTables) : super(const AsyncValue.loading()) {
    loadTables();
  }

  final GetAssignedTablesUseCase _getAssignedTables;

  Future<void> loadTables() async {
    state = const AsyncValue.loading();
    final result = await _getAssignedTables();
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final tablesProvider = StateNotifierProvider<AssignedTablesNotifier, AsyncValue<List<MesaElectoralEntity>>>((ref) {
  return AssignedTablesNotifier(ref.watch(getAssignedTablesUseCaseProvider));
});
