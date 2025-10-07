import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmContextModelConnector {
  final String apiKey;
  PalmContextModelConnector({required this.apiKey});

  Future<String> setContext(
    String context, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for context
    final uri = Uri.parse('https://api.palm.com/v1/context');

    final body = {
      'context': context,
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
        'Failed to set context: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
