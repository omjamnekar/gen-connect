import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiEmbeddingUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiEmbeddingUsecase({required this.apiKey, required this.model});

  Future<List<double>> getEmbedding(String text) async {
    final response = await _dio.post(
      ApiConstants.geminiEmbedText(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'text': text},
    );
    if (response.statusCode == 200) {
      return List<double>.from(response.data['embedding'] ?? []);
    } else {
      throw Exception('Failed to get embedding: \n${response.data}');
    }
  }
}
