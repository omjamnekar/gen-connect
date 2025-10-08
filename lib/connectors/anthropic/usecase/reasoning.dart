import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicReasoningUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicReasoningUsecase({required this.apiKey, required this.model});

  Future<String> getReasoning(String prompt) async {
    final url = ApiConstants.anthropicReasoning;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'prompt': prompt},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['reasoning'] ?? '';
    } else {
      throw Exception('Failed to get reasoning: \n${response.data}');
    }
  }
}
