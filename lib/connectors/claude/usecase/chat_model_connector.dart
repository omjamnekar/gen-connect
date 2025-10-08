import 'dart:convert';
import 'package:gen_connect/enums/claude.dart';
import 'package:http/http.dart' as http;

class CloudeChatModelConnector {
  final String apiKey;

  final String apiVersion;

  CloudeChatModelConnector({
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
    final url = Uri.parse('https://api.anthropic.com/v1/messages');
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
      if (extraOptions != null) ...extraOptions,
      if (stream) 'stream': true,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['content'] is List && data['content'].isNotEmpty) {
        // Return the first text block
        final textBlock = data['content'].firstWhere(
          (block) => block['type'] == 'text',
          orElse: () => null,
        );
        return textBlock != null ? textBlock['text'] ?? '' : '';
      }
      return '';
    } else {
      throw Exception(
        'Claude API error: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
