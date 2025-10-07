import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicCodeUsecase {
  final String apiKey;
  final String model;
  AnthropicCodeUsecase({required this.apiKey, required this.model});

  Future<String> generateCode(String prompt) async {
    final url = Uri.parse('https://api.anthropic.com/v1/complete');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': model,
        'prompt': prompt,
        'max_tokens_to_sample': 256,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['completion'] ?? '';
    } else {
      throw Exception('Failed to generate code:${response.body}');
    }
  }
}
