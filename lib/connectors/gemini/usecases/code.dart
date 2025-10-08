import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiCodeUsecase {
  final String apiKey;
  final String model;
  GeminiCodeUsecase({required this.apiKey, required this.model});

  Future<String> generateCode(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:generateCode',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': {'text': prompt},
        'maxOutputTokens': 256,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates']?[0]?['output'] ?? '';
    } else {
      throw Exception('Failed to generate code: \n${response.body}');
    }
  }
}
