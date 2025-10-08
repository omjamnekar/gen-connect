import 'package:dio/dio.dart';

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
class APIException implements DioException {
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

  @override
  DioExceptionReadableStringBuilder? stringBuilder;

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  // TODO: implement error
  Object? get error => throw UnimplementedError();

  @override
  // TODO: implement requestOptions
  RequestOptions get requestOptions => throw UnimplementedError();

  @override
  // TODO: implement response
  Response? get response => throw UnimplementedError();

  @override
  // TODO: implement stackTrace
  StackTrace get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement type
  DioExceptionType get type => throw UnimplementedError();
}
