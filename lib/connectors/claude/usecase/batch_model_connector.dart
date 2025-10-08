import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeBatchModelConnector {
  final String apiKey;
  final String apiVersion;

  ClaudeBatchModelConnector({
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<List<Map<String, dynamic>>> sendBatchPrompts(
    List<Map<String, dynamic>> batchRequests,
    String modelName,
  ) async {
    final url = Uri.parse('https://api.anthropic.com/v1/batch');
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
    };
    final body = {'model': modelName, 'requests': batchRequests};
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['responses'] ?? []);
    } else {
      throw Exception('Claude Batch API error: ${response.statusCode}');
    }
  }
}
