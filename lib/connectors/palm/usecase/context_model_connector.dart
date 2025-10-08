import 'package:gen_connect/gen_manager.dart';
import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';

class PalmContextModelConnector {
  final String apiKey;
  final Dio _dio;

  PalmContextModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> setContext(
    String context, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final uri = ApiConstants.palmContext;

    final body = {
      'context': context,
      if (extraOptions != null) ...extraOptions,
    };

    try {
      final response = await _dio.post(
        uri,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'Failed to set context: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
