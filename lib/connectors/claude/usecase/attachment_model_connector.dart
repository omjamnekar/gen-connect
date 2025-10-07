import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeAttachmentModelConnector {
  final String apiKey;
  final String apiVersion;

  ClaudeAttachmentModelConnector({
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<Map<String, dynamic>> sendAttachmentPrompt(
    String prompt,
    String modelName, {
    required List<Map<String, dynamic>> attachments,
    Map<String, dynamic>? extraOptions,
    int? maxTokens = 1024,
    double? temperature = 1.0,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
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
      'attachments': attachments,
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
      throw Exception('Claude Attachment API error: ${response.statusCode}');
    }
  }
}
