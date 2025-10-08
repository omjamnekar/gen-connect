import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokContextModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokContextModelConnector({required this.apiKey, required this.model});

  Future<String> setContext(String context) async {
    // Replace with the actual Grok API endpoint for setting context
    final uri = Uri.parse('https://api.grok.com/v1/context');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'context': context}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to set context: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
