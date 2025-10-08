/// Custom error class for AI connector errors.
class AIConnectorError implements Exception {
  final String message;
  final Exception? innerException;

  AIConnectorError(this.message, [this.innerException]);

  @override
  String toString() {
    if (innerException != null) {
      return 'AIConnectorError: $message\nInner: $innerException';
    }
    return 'AIConnectorError: $message';
  }
}

/// Custom exception class for API errors.
class APIException implements Exception {
  final String message;
  final int? statusCode;
  final Exception? innerException;

  APIException(this.message, {this.statusCode, this.innerException});

  @override
  String toString() {
    String base = 'APIException: $message';
    if (statusCode != null) base += ' (Status: $statusCode)';
    if (innerException != null) base += '\nInner: $innerException';
    return base;
  }
}
