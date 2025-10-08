import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiReasoningUsecase {
  final String apiKey;
  final String model;
  GeminiReasoningUsecase({required this.apiKey, required this.model});

  Future<String> getReasoning(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:getReasoning',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': {'text': prompt},
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['reasoning'] ?? '';
    } else {
      throw Exception('Failed to get reasoning: \n${response.body}');
    }
  }
}
