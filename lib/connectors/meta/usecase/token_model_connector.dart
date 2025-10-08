import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class MetaTokenModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaTokenModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<int> countTokens(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final uri = ApiConstants.metaTokenCount;
    final body = {'text': text, if (extraOptions != null) ...extraOptions};

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
      return data['count'] ?? 0;
    } on DioException catch (e) {
      throw Exception(
        'Meta token count error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
