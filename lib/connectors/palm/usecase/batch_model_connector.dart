import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmBatchModelConnector {
  final String apiKey;
  PalmBatchModelConnector({required this.apiKey});

  Future<String> batchRequest(List<String> prompts) async {
    // Replace with the actual Palm API endpoint for batch requests
    final uri = Uri.parse('https://api.palm.com/v1/batch');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'prompts': prompts}),
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
