import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiTokenUsecase {
  final String apiKey;
  final String model;
  GeminiTokenUsecase({required this.apiKey, required this.model});

  Future<int> countTokens(String text) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:countTokens',
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
      return data['tokenCount'] ?? 0;
    } else {
      throw Exception('Failed to count tokens: \n${response.body}');
    }
  }
}
