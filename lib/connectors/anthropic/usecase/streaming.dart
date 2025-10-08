import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicStreamingUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicStreamingUsecase({required this.apiKey, required this.model});

  Stream<String> streamCompletion(String prompt) async* {
    final url = ApiConstants.anthropicStreamComplete;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'prompt': prompt, 'max_tokens_to_sample': 256},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      for (final chunk in data['stream'] ?? []) {
        yield chunk;
      }
    } else {
      throw Exception('Failed to stream completion: \n${response.data}');
    }
  }
}
