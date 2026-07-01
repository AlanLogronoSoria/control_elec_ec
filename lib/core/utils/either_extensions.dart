/// Extension methods on [Either] for cleaner functional error handling.
library;

import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

extension EitherExtensions<T> on Either<Failure, T> {
  /// Returns the right value or throws the left failure message.
  T getOrThrow() => fold(
        (l) => throw Exception(l.message),
        (r) => r,
      );

  /// Returns the right value or null if left.
  T? getOrNull() => fold((_) => null, (r) => r);

  /// Returns the right value or a default if left.
  T getOrDefault(T defaultValue) => fold((_) => defaultValue, (r) => r);

  /// Executes [onSuccess] if right, [onFailure] if left.
  void foldVoid({required void Function(Failure) onFailure, required void Function(T) onSuccess}) =>
      fold(onFailure, onSuccess);
}
