import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiTextUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiTextUsecase({required this.apiKey, required this.model});

  Future<String> generateText(String prompt) async {
    final response = await _dio.post(
      ApiConstants.geminiGenerateText(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'prompt': {'text': prompt},
        'maxOutputTokens': 256,
      },
    );
    if (response.statusCode == 200) {
      return response.data['candidates']?[0]?['output'] ?? '';
    } else {
      throw Exception('Failed to generate text: \n${response.data}');
    }
  }
}
