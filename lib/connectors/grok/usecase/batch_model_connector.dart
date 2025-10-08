import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokBatchModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokBatchModelConnector({required this.apiKey, required this.model});

  Future<String> batchRequest(List<String> prompts) async {
    // Replace with the actual Grok API endpoint for batch requests
    final uri = Uri.parse('https://api.grok.com/v1/batch');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'prompts': prompts}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to send batch request: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
