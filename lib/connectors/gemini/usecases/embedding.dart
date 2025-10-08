import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiEmbeddingUsecase {
  final String apiKey;
  final String model;
  GeminiEmbeddingUsecase({required this.apiKey, required this.model});

  Future<List<double>> getEmbedding(String text) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:embedText',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'text': text}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<double>.from(data['embedding'] ?? []);
    } else {
      throw Exception('Failed to get embedding: \n${response.body}');
    }
  }
}
