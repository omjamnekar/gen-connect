import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicEmbeddingUsecase {
  Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicEmbeddingUsecase({required this.apiKey, required this.model});

  Future<List<double>> getEmbedding(String text) async {
    final url = ApiConstants.anthropicEmbeddings;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'input': text},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return List<double>.from(data['embedding'] ?? []);
    } else {
      throw Exception('Failed to get embedding: \n${response.data}');
    }
  }
}
