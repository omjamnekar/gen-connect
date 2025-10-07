import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicTokenUsecase {
  final String apiKey;
  final String model;
  AnthropicTokenUsecase({required this.apiKey, required this.model});

  Future<int> countTokens(String text) async {
    final url = Uri.parse('https://api.anthropic.com/v1/tokenize');
    final response = await http.post(
      url,
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'input': text,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token_count'] ?? 0;
    } else {
      throw Exception('Failed to count tokens: \n${response.body}');
    }
  }
}
