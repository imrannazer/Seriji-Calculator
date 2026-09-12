import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

final class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

final class CalculationFailure extends Failure {
  const CalculationFailure(super.message);
}

final class ImportFailure extends Failure {
  const ImportFailure(super.message);
}

final class ExportFailure extends Failure {
  const ExportFailure(super.message);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred.']);
}
