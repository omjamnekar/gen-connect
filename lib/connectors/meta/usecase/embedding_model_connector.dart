import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaEmbeddingModelConnector {
  final String apiKey;
  MetaEmbeddingModelConnector({required this.apiKey});

  Future<List<double>> getEmbedding(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/embedding/generate');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': text,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<double>.from(data['embedding'] ?? []);
      } else {
        throw APIException(
          'Meta embedding error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta embedding model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
