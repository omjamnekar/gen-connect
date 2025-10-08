import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicBatchUsecase {
  final String apiKey;
  final String model;
  AnthropicBatchUsecase({required this.apiKey, required this.model});

  Future<List<String>> batchGenerate(List<String> prompts) async {
    final url = Uri.parse('https://api.anthropic.com/v1/batch-complete');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': model,
        'prompts': prompts,
        'max_tokens_to_sample': 256,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['completions'] ?? []);
    } else {
      throw Exception('Failed to batch generate: \n${response.body}');
    }
  }
}
