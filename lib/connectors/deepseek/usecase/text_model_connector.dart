import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<DeepSeekModel> deepseekTextModels = {
  DeepSeekModel.deepseekChat,
  DeepSeekModel.deepseekMath,
};

class DeepSeekTextModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekTextModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekTextModels.contains(model)) {
      throw Exception(
        'Model ${model.value} is not text-capable. Allowed: ${deepseekTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final response = await _dio.post(
      ApiConstants.deepSeekText,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': model.value,
        'prompt': prompt,
        if (temperature != null) 'temperature': temperature,
        if (maxTokens != null) 'max_tokens': maxTokens,
        if (systemPrompt != null) 'system_prompt': systemPrompt,
        if (extraOptions != null) ...extraOptions,
      },
    );
    if (response.statusCode == 200) {
      return response.data['result'] ?? '';
    } else {
      throw Exception('Failed to send prompt: \n${response.data}');
    }
  }
}
