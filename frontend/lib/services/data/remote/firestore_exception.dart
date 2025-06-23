/// Custom exception class for FirestoreService operations.
/// This allows repositories and higher layers to catch a specific type of error
/// and get details without being directly coupled to FirebaseException.
class FirestoreServiceException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  FirestoreServiceException(this.message, {this.code, this.stackTrace});

  @override
  String toString() {
    return 'FirestoreServiceException: $message ${code != null ? '(Code: $code)' : ''}';
  }
}
