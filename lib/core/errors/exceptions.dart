class AppException implements Exception {
  const AppException(this.message);
  final String message;
  @override
  String toString() => 'AppException: $message';
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class StorageException extends AppException {
  const StorageException(super.message);
}

class CalculationException extends AppException {
  const CalculationException(super.message);
}
