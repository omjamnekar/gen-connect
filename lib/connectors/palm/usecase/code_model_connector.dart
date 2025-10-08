import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:dio/dio.dart';

class PalmCodeModelConnector {
  final String apiKey;
  final Dio _dio;

  PalmCodeModelConnector({required this.apiKey}) : _dio = GenConnectManager.dio;

  Future<String> sendCodePrompt(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final uri = ApiConstants.palmCode;

    final body = {'code': code, if (extraOptions != null) ...extraOptions};

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
        'Failed to send code prompt: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
