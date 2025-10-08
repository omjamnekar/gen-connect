import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeToolModelConnector {
  final String apiKey;
  final String apiVersion;

  ClaudeToolModelConnector({
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<Map<String, dynamic>> sendToolPrompt(
    String prompt,
    String modelName, {
    required List<Map<String, dynamic>> tools,
    Map<String, dynamic>? extraOptions,
    int? maxTokens = 1024,
    double? temperature = 1.0,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
    String? toolChoice,
  }) async {
    final url = Uri.parse('https://api.anthropic.com/v1/messages');
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
      'tools': tools,
      if (toolChoice != null) 'tool_choice': toolChoice,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Claude Tool API error: ${response.statusCode}');
    }
  }
}
