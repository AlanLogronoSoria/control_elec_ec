/// Providers para el módulo Coordinador de Recinto.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/injection_container.dart';
import '../../domain/entities/recinto_entities.dart';
import '../../domain/usecases/recinto_usecases.dart';

// ── Casos de Uso ─────────────────────────────────────────────────────────

final getRecintoProgressUseCaseProvider = Provider<GetRecintoProgressUseCase>((ref) {
  return sl<GetRecintoProgressUseCase>();
});

final getVeedoresUseCaseProvider = Provider<GetVeedoresUseCase>((ref) {
  return sl<GetVeedoresUseCase>();
});

final assignTableUseCaseProvider = Provider<AssignTableUseCase>((ref) {
  return sl<AssignTableUseCase>();
});

// ── Estado (Providers) ───────────────────────────────────────────────────

/// Estado del progreso del recinto.
class RecintoProgressNotifier extends StateNotifier<AsyncValue<RecintoProgressEntity>> {
  RecintoProgressNotifier(this._getProgress) : super(const AsyncValue.loading()) {
    loadProgress();
  }

  final GetRecintoProgressUseCase _getProgress;

  Future<void> loadProgress() async {
    state = const AsyncValue.loading();
    final result = await _getProgress();
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final recintoProgressProvider = StateNotifierProvider<RecintoProgressNotifier, AsyncValue<RecintoProgressEntity>>((ref) {
  return RecintoProgressNotifier(ref.watch(getRecintoProgressUseCaseProvider));
});

/// Estado de los veedores asignados.
class VeedoresNotifier extends StateNotifier<AsyncValue<List<VeedorAsignadoEntity>>> {
  VeedoresNotifier(this._getVeedores) : super(const AsyncValue.loading()) {
    loadVeedores();
  }

  final GetVeedoresUseCase _getVeedores;

  Future<void> loadVeedores() async {
    state = const AsyncValue.loading();
    final result = await _getVeedores();
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final veedoresProvider = StateNotifierProvider<VeedoresNotifier, AsyncValue<List<VeedorAsignadoEntity>>>((ref) {
  return VeedoresNotifier(ref.watch(getVeedoresUseCaseProvider));
});
