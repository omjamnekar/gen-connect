import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicBatchUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicBatchUsecase({required this.apiKey, required this.model});

  Future<List<String>> batchGenerate(List<String> prompts) async {
    final url = ApiConstants.anthropicBatchComplete;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'prompts': prompts, 'max_tokens_to_sample': 256},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return List<String>.from(data['completions'] ?? []);
    } else {
      throw Exception('Failed to batch generate: \n${response.data}');
    }
  }
}
