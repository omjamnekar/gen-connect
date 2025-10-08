import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/claude.dart';

class CloudeChatModelConnector {
  final Dio dio;
  final String apiKey;
  final String apiVersion;

  CloudeChatModelConnector({
    required this.dio,
    required this.apiKey,

    this.apiVersion = '2023-06-01',
  });

  Future<String> sendChatPrompt(
    String prompt,

    ClaudeModel model, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens = 1024,
    double? temperature = 1.0,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
    bool stream = false,
  }) async {
    final url = ApiConstants.claudeMessages;
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
    };
    final body = {
      'model': model.name,
      'max_tokens': maxTokens,
      'temperature': temperature,
      if (systemPrompt != null) 'system': systemPrompt,
      'messages':
          messages ??
          [
            {'role': 'user', 'content': prompt},
          ],
    };
    final response = await dio.post(
      url,
      options: Options(headers: headers),
      data: body,
    );
    if (response.statusCode == 200) {
      return response.data['response'];
    } else {
      throw Exception('Claude Chat API error: ${response.statusCode}');
    }
  }
}
