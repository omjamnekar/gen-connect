import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiCodeUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiCodeUsecase({required this.apiKey, required this.model});

  Future<String> generateCode(String prompt) async {
    final response = await _dio.post(
      ApiConstants.geminiGenerateCode(model),
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
      throw Exception('Failed to generate code: \n${response.data}');
    }
  }
}
