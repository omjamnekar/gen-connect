import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiReasoningUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiReasoningUsecase({required this.apiKey, required this.model});

  Future<String> getReasoning(String prompt) async {
    final response = await _dio.post(
      ApiConstants.geminiGetReasoning(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'prompt': {'text': prompt},
      },
    );
    if (response.statusCode == 200) {
      return response.data['reasoning'] ?? '';
    } else {
      throw Exception('Failed to get reasoning: \n${response.data}');
    }
  }
}
