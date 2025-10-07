import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmReasoningModelConnector {
  final String apiKey;
  PalmReasoningModelConnector({required this.apiKey});

  Future<String> reason(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for reasoning
    final uri = Uri.parse('https://api.palm.com/v1/reasoning');

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
        'Failed to get reasoning: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
