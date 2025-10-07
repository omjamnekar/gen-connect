import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmToolModelConnector {
  final String apiKey;
  PalmToolModelConnector({required this.apiKey});

  Future<String> useTool(
    String toolName,
    String input, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for tool usage
    final uri = Uri.parse('https://api.palm.com/v1/tool');

    final body = {
      'tool': toolName,
      'input': input,
      if (extraOptions != null) ...extraOptions,
    };

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
        'Failed to use tool: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
