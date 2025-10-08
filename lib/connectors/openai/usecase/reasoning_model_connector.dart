import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<OpenAIModel> reasoningCapableModels = {
  OpenAIModel.o3,
  OpenAIModel.o3Mini,
  OpenAIModel.o3Pro,
  OpenAIModel.o4Mini,
};

class OpenAIReasoningModelConnector {
  final String apiKey;
  final Dio _dio;

  OpenAIReasoningModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  // @override
  String get name => Models.OPENAI.name;

  // @override
  Future<String> sendPromptReasoning(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIChatCompletions();
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
        'OpenAI Reasoning API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<String> sendImageReasoning(
    String imagePath,
    OpenAIModel model, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIImageGenerations();
    final body = {
      'model': model.value,
      'prompt': prompt ?? '',
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
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'OpenAI Reasoning image API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<String> sendDocumentReasoning(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIFiles();
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(documentPath),
      if (extraOptions != null) ...extraOptions,
    });

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'OpenAI Reasoning file API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
