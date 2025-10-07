import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicTierUsecase {
  final String apiKey;
  final String model;
  AnthropicTierUsecase({required this.apiKey, required this.model});

  Future<String> getTier() async {
    final url = Uri.parse('https://api.anthropic.com/v1/tier');
    final response = await http.get(
      url,
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['tier'] ?? '';
    } else {
      throw Exception('Failed to get tier: \n${response.body}');
    }
  }
}
