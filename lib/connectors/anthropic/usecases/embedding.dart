import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicEmbeddingUsecase {
  final String apiKey;
  final String model;
  AnthropicEmbeddingUsecase({required this.apiKey, required this.model});

  Future<List<double>> getEmbedding(String text) async {
    final url = Uri.parse('https://api.anthropic.com/v1/embeddings');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({'model': model, 'input': text}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<double>.from(data['embedding'] ?? []);
    } else {
      throw Exception('Failed to get embedding: \n${response.body}');
    }
  }
}
