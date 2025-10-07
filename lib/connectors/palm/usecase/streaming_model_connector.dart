import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmStreamingModelConnector {
  final String apiKey;
  PalmStreamingModelConnector({required this.apiKey});

  Stream<String> streamPrompt(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async* {
    // Replace with the actual Palm API endpoint for streaming
    final uri = Uri.parse('https://api.palm.com/v1/stream');

    final request = http.Request('POST', uri)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      });

    final response = await request.send();
    if (response.statusCode == 200) {
      await for (var chunk in response.stream.transform(utf8.decoder)) {
        yield chunk;
      }
    } else {
      throw Exception('Failed to stream prompt: \\${response.statusCode}');
    }
  }
}
