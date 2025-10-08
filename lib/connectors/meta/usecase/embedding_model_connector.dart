import 'package:dio/dio.dart';
import '../../../core/errors.dart';
import '../../../core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaEmbeddingModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaEmbeddingModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<List<double>> getEmbedding(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {'text': text, if (extraOptions != null) ...extraOptions};

      final response = await _dio.post(
        ApiConstants.metaEmbeddingGenerate,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return List<double>.from(data['embedding'] ?? []);
      } else {
        throw APIException(
          'Meta embedding error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta embedding model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
