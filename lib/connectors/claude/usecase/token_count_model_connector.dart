import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeTokenCountModelConnector {
  final String apiKey;
  final String apiVersion;

  ClaudeTokenCountModelConnector({
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<int> countTokens(String prompt, String modelName) async {
    final url = Uri.parse('https://api.anthropic.com/v1/messages/count-tokens');
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
    };
    final body = {'model': modelName, 'prompt': prompt};
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token_count'] ?? 0;
    } else {
      throw Exception('Claude Token Count API error: ${response.statusCode}');
    }
  }
}
