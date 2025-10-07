import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmEmbeddingModelConnector {
  final String apiKey;
  PalmEmbeddingModelConnector({required this.apiKey});

  Future<String> getEmbedding(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for embeddings
    final uri = Uri.parse('https://api.palm.com/v1/embedding');

    final body = {'text': text, if (extraOptions != null) ...extraOptions};

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
        'Failed to get embedding: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
