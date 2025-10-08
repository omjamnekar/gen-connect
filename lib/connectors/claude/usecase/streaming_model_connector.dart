import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeStreamingModelConnector {
  final String apiKey;
  final String apiVersion;

  ClaudeStreamingModelConnector({
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Stream<String> streamChatPrompt(
    String prompt,
    String modelName, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens = 1024,
    double? temperature = 1.0,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
  }) async* {
    final url = Uri.parse('https://api.anthropic.com/v1/messages');
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
      'accept': 'text/event-stream',
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
      if (extraOptions != null) ...extraOptions,
      'stream': true,
    };
    final request = http.Request('POST', url)
      ..headers.addAll(headers)
      ..body = jsonEncode(body);
    final response = await request.send();
    if (response.statusCode == 200) {
      await for (var chunk in response.stream.transform(utf8.decoder)) {
        yield chunk;
      }
    } else {
      throw Exception('Claude Streaming API error: ${response.statusCode}');
    }
  }
}
