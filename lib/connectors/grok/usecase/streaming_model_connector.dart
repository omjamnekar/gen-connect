import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokStreamingModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokStreamingModelConnector({required this.apiKey, required this.model});

  Stream<String> streamPrompt(String prompt) async* {
    // Replace with the actual Grok API endpoint for streaming
    final uri = Uri.parse('https://api.grok.com/v1/stream');

    final request = http.Request('POST', uri)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({'model': model.name, 'prompt': prompt});

    final response = await request.send();
    if (response.statusCode == 200) {
      await for (var chunk in response.stream.transform(utf8.decoder)) {
        // You may want to split by newlines or handle JSON events depending on API
        yield chunk;
      }
    } else {
      throw Exception('Failed to stream prompt: \\${response.statusCode}');
    }
  }
}
