import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/constants/api.dart';

const Set<OpenAIModel> imageCapableModels = {OpenAIModel.gptImage1};

class OpenAIImageModelConnector {
  final String apiKey;
  final Dio _dio;

  OpenAIImageModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  String get name => Models.OPENAI.name;

  Future<String> sendPromptToImage(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIImageGenerations();
    final body = {
      'model': model.value,
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (systemPrompt != null) 'system_prompt': systemPrompt,
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
        'OpenAI Image API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<String> sendImagetoImage(
    String imagePath,
    OpenAIModel model, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIImageGenerations();
    final formData = FormData.fromMap({
      'model': model.value,
      'image': await MultipartFile.fromFile(imagePath),
      if (prompt != null) 'prompt': prompt,
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
        'OpenAI Image-to-Text API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
