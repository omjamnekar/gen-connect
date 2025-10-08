import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicContextUsecase {
  final String apiKey;
  final String model;
  AnthropicContextUsecase({required this.apiKey, required this.model});

  Future<String> getContext(String contextId) async {
    final url = Uri.parse('https://api.anthropic.com/v1/context');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({'model': model, 'context_id': contextId}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['context'] ?? '';
    } else {
      throw Exception('Failed to get context: \n${response.body}');
    }
  }
}
