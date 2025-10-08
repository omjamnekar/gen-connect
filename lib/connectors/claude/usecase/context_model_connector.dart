import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';

class ClaudeContextModelConnector {
  final Dio dio;
  final String apiKey;
  final String apiVersion;

  ClaudeContextModelConnector({
    required this.dio,
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<Map<String, dynamic>> sendContextManagedPrompt(
    String prompt,
    String modelName, {
    Map<String, dynamic>? contextManagement,
    Map<String, dynamic>? extraOptions,
    int? maxTokens = 1024,
    double? temperature = 1.0,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
  }) async {
    final url = ApiConstants.claudeMessages;
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
    };
    final body = {
      'model': modelName,
      'max_tokens': maxTokens,
      'temperature': temperature,
      if (systemPrompt != null) 'system': systemPrompt,
      'messages':
          messages ??
          [
            {'role': 'user', 'content': prompt},
          ],
      if (contextManagement != null) 'context_management': contextManagement,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await dio.post(
      url,
      options: Options(headers: headers),
      data: body,
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
        'Claude Context Managed API error: ${response.statusCode}',
      );
    }
  }
}
