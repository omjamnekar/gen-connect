import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicStreamingUsecase {
  final String apiKey;
  final String model;
  AnthropicStreamingUsecase({required this.apiKey, required this.model});

  Stream<String> streamCompletion(String prompt) async* {
    final url = Uri.parse('https://api.anthropic.com/v1/stream-complete');
    final response = await http.post(
      url,
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'prompt': prompt,
        'max_tokens_to_sample': 256,
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
