import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmTextModelConnector {
  final String apiKey;
  PalmTextModelConnector({required this.apiKey});

  Future<String> sendTextPrompt(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for text prompts
    final uri = Uri.parse('https://api.palm.com/v1/text');

    final body = {'prompt': prompt, if (extraOptions != null) ...extraOptions};

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
        'Failed to send text prompt: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
