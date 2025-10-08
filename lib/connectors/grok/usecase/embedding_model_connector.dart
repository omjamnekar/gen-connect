import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';

class GrokEmbeddingModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final GrokModel model;

  GrokEmbeddingModelConnector({required this.apiKey, required this.model});

  Future<String> embed(String text) async {
    final response = await _dio.post(
      ApiConstants.grokEmbeddingGenerate,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'model': model.name, 'text': text},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
        'Failed to get embedding: ${response.statusCode} ${response.data}',
      );
    }
  }
}
