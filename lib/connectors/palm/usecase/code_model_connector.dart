import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmCodeModelConnector {
  final String apiKey;
  PalmCodeModelConnector({required this.apiKey});

  Future<String> sendCodePrompt(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for code prompts
    final uri = Uri.parse('https://api.palm.com/v1/code');

    final body = {'code': code, if (extraOptions != null) ...extraOptions};

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to send code prompt: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
