import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/meta.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaTextModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaTextModelConnector({required this.apiKey}) : _dio = GenConnectManager.dio;

  String get name => Models.META.name;

  Future<String> sendPrompt(
    String prompt, {
    required MetaModel model,
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'model': model.value,
        'prompt': prompt,
        if (temperature != null) 'temperature': temperature,
        if (maxTokens != null) 'max_tokens': maxTokens,
        if (systemPrompt != null) 'system_prompt': systemPrompt,
        if (extraOptions != null) ...extraOptions,
      };

      final response = await _dio.post(
        ApiConstants.metaTextGenerate,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['result'] ?? '';
      } else {
        throw APIException(
          'Meta text generation error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta text model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
