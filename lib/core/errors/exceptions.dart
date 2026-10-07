sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class InvalidInputException extends AppException {
  const InvalidInputException(super.message);
}

final class DataLoadException extends AppException {
  const DataLoadException(super.message);
}
