import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class MetaToolModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaToolModelConnector({required this.apiKey}) : _dio = GenConnectManager.dio;

  Future<String> runTool(
    String toolName,
    Map<String, dynamic> params, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final uri = ApiConstants.metaToolRun;
    final body = {
      'tool': toolName,
      'params': params,
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
      final data = response.data;
      return data['result'] ?? '';
    } on DioException catch (e) {
      throw Exception(
        'Meta tool run error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
