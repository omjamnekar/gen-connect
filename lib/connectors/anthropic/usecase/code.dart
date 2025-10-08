import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicCodeUsecase {
  Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicCodeUsecase({required this.apiKey, required this.model});

  Future<String> generateCode(String prompt) async {
    final url = ApiConstants.anthropicComplete;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'prompt': prompt, 'max_tokens_to_sample': 256},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['completion'] ?? '';
    } else {
      throw Exception('Failed to generate code:${response.data}');
    }
  }
}
