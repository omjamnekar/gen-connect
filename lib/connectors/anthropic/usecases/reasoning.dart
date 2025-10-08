import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicReasoningUsecase {
  final String apiKey;
  final String model;
  AnthropicReasoningUsecase({required this.apiKey, required this.model});

  Future<String> getReasoning(String prompt) async {
    final url = Uri.parse('https://api.anthropic.com/v1/reasoning');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({'model': model, 'prompt': prompt}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['reasoning'] ?? '';
    } else {
      throw Exception('Failed to get reasoning: \n${response.body}');
    }
  }
}
