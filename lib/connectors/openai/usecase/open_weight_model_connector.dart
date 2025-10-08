import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/openai.dart';

import 'package:gen_connect/enums/models.dart';

final List<OpenAIModel> openWeightCapableModels = [
  OpenAIModel.gptOss120b,
  OpenAIModel.gptOss20b,
  // Add other open-weight-capable models here as needed
];

class OpenAIOpenWeightModelConnector {
  final String apiKey;
  final Dio _dio;

  OpenAIOpenWeightModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  String get name => Models.OPENAI.name;

  Future<String> sendChatPrompt(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = '${ApiConstants.openaiBaseUrl}/chat';
    final body = {
      'model': model.value,
      'messages': [
        if (systemPrompt != null) {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': prompt},
      ],
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (extraOptions != null) ...extraOptions,
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      final data = response.data;
      return data['choices']?[0]?['message']?['content'] ?? '';
    } on DioError catch (e) {
      throw Exception(
        'OpenAI OpenWeight API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<String> sendCompletionPrompt(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = '${ApiConstants.openaiBaseUrl}/completion';
    final body = {
      'model': model.value,
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (extraOptions != null) ...extraOptions,
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      final data = response.data;
      return data['choices']?[0]?['text'] ?? '';
    } on DioError catch (e) {
      throw Exception(
        'OpenAI OpenWeight API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
