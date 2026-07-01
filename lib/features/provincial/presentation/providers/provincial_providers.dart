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
