import 'package:gen_connect/gen_manager.dart';
import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';

class PalmEmbeddingModelConnector {
  final String apiKey;
  final Dio _dio;

  PalmEmbeddingModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> getEmbedding(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final uri = ApiConstants.palmEmbedding;

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
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'Failed to get embedding: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
