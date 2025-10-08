import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokTokenModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokTokenModelConnector({required this.apiKey, required this.model});

  Future<int> countTokens(String text) async {
    // Replace with the actual Grok API endpoint for token counting
    final uri = Uri.parse('https://api.grok.com/v1/tokenize');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming the response contains a field 'token_count'
      return data['token_count'] as int;
    } else {
      throw Exception(
        'Failed to count tokens: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
