import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiTokenUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiTokenUsecase({required this.apiKey, required this.model});

  Future<int> countTokens(String text) async {
    final response = await _dio.post(
      ApiConstants.geminiCountTokens(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'text': text},
    );
    if (response.statusCode == 200) {
      return response.data['tokenCount'] ?? 0;
    } else {
      throw Exception('Failed to count tokens: \n${response.data}');
    }
  }
}
