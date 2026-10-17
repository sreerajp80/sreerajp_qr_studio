/// Typed domain exceptions (engineering standard §11.3).
///
/// The [message] is a technical note for logs, never shown to the user; the
/// state layer turns an exception into its own UI state.
sealed class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType($message)';
}

/// Local storage failed: database, secure storage, or field encryption.
final class StorageException extends AppException {
  const StorageException(super.message, {super.cause});
}
