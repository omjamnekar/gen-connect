import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiStreamingUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiStreamingUsecase({required this.apiKey, required this.model});

  Stream<String> streamCompletion(String prompt) async* {
    final response = await _dio.post(
      ApiConstants.geminiStreamGenerate(model),
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
      for (final chunk in response.data['stream'] ?? []) {
        yield chunk;
      }
    } else {
      throw Exception('Failed to stream completion: \n${response.data}');
    }
  }
}
