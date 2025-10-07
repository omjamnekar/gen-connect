import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicImageUsecase {
  final String apiKey;
  final String model;
  AnthropicImageUsecase({required this.apiKey, required this.model});

  Future<String> generateImage(String prompt) async {
    final url = Uri.parse('https://api.anthropic.com/v1/generate-image');
    final response = await http.post(
      url,
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'prompt': prompt,
        'size': '1024x1024',
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['image_url'] ?? '';
    } else {
      throw Exception('Failed to generate image: \n${response.body}');
    }
  }
}
