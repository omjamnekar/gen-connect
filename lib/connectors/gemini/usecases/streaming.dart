import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiStreamingUsecase {
  final String apiKey;
  final String model;
  GeminiStreamingUsecase({required this.apiKey, required this.model});

  Stream<String> streamCompletion(String prompt) async* {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:streamGenerate',
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
      for (final chunk in data['stream'] ?? []) {
        yield chunk;
      }
    } else {
      throw Exception('Failed to stream completion: \n${response.body}');
    }
  }
}
