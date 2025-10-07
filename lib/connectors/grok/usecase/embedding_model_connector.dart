import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokEmbeddingModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokEmbeddingModelConnector({required this.apiKey, required this.model});

  Future<String> embed(String text) async {
    // Replace with the actual Grok API endpoint for embedding
    final uri = Uri.parse('https://api.grok.com/v1/embedding');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'text': text}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to get embedding: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
