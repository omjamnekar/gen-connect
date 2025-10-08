import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokToolModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokToolModelConnector({required this.apiKey, required this.model});

  Future<String> useTool(String toolName, String input) async {
    // Replace with the actual Grok API endpoint for tool usage
    final uri = Uri.parse('https://api.grok.com/v1/tool');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'tool': toolName, 'input': input}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to use tool: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
