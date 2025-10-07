import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokReasoningModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokReasoningModelConnector({required this.apiKey, required this.model});

  Future<String> reason(String prompt) async {
    // Replace with the actual Grok API endpoint for reasoning
    final uri = Uri.parse('https://api.grok.com/v1/reasoning');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to get reasoning: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
