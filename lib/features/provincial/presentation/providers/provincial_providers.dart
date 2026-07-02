/// Providers para el Coordinador Provincial.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/injection_container.dart';
import '../../domain/entities/provincial_entities.dart';
import '../../domain/usecases/provincial_usecases.dart';

// ── Casos de Uso ─────────────────────────────────────────────────────────

final getResumenGlobalUseCaseProvider = Provider<GetResumenGlobalUseCase>((ref) {
  return sl<GetResumenGlobalUseCase>();
});

final getAvancePorRecintoUseCaseProvider =
    Provider<GetAvancePorRecintoUseCase>((ref) {
  return sl<GetAvancePorRecintoUseCase>();
});

final getActaDetailUseCaseProvider =
    Provider<GetActaDetailUseCase>((ref) {
  return sl<GetActaDetailUseCase>();
});

final createPrecinctUseCaseProvider =
    Provider<CreatePrecinctUseCase>((ref) {
  return sl<CreatePrecinctUseCase>();
});

final getAllPrecinctsUseCaseProvider =
    Provider<GetAllPrecinctsUseCase>((ref) {
  return sl<GetAllPrecinctsUseCase>();
});

final assignCoordinatorUseCaseProvider =
    Provider<AssignCoordinatorToPrecinctUseCase>((ref) {
  return sl<AssignCoordinatorToPrecinctUseCase>();
});

final getCoordinadoresUseCaseProvider =
    Provider<GetCoordinadoresRecintoUseCase>((ref) {
  return sl<GetCoordinadoresRecintoUseCase>();
});

// ── Estado ───────────────────────────────────────────────────────────────

class ResumenGlobalNotifier extends StateNotifier<AsyncValue<ResumenProvincialEntity>> {
  ResumenGlobalNotifier(this._getResumenGlobal) : super(const AsyncValue.loading()) {
    loadResumen();
  }

  final GetResumenGlobalUseCase _getResumenGlobal;

  Future<void> loadResumen() async {
    state = const AsyncValue.loading();
    final result = await _getResumenGlobal();
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final resumenGlobalProvider = StateNotifierProvider<ResumenGlobalNotifier, AsyncValue<ResumenProvincialEntity>>((ref) {
  return ResumenGlobalNotifier(ref.watch(getResumenGlobalUseCaseProvider));
});

class AvancePorRecintoNotifier
    extends StateNotifier<AsyncValue<List<AvanceRecintoEntity>>> {
  AvancePorRecintoNotifier(this._getAvance)
      : super(const AsyncValue.loading()) {
    load();
  }

  final GetAvancePorRecintoUseCase _getAvance;

  Future<void> load() async {
    state = const AsyncValue.loading();
    final result = await _getAvance();
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final avancePorRecintoProvider =
    StateNotifierProvider<AvancePorRecintoNotifier,
        AsyncValue<List<AvanceRecintoEntity>>>((ref) {
  return AvancePorRecintoNotifier(
    ref.watch(getAvancePorRecintoUseCaseProvider),
  );
});

class PrecinctListNotifier
    extends StateNotifier<AsyncValue<List<AvanceRecintoEntity>>> {
  PrecinctListNotifier(this._getAll)
      : super(const AsyncValue.loading()) {
    load();
  }

  final GetAllPrecinctsUseCase _getAll;

  Future<void> load() async {
    state = const AsyncValue.loading();
    final result = await _getAll();
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final precinctListProvider =
    StateNotifierProvider<PrecinctListNotifier,
        AsyncValue<List<AvanceRecintoEntity>>>((ref) {
  return PrecinctListNotifier(ref.watch(getAllPrecinctsUseCaseProvider));
});
