import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiImageUsecase {
  final String apiKey;
  final String model;
  GeminiImageUsecase({required this.apiKey, required this.model});

  Future<String> generateImage(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:generateImage',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': {'text': prompt},
        'imageSize': '1024x1024',
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['imageUrl'] ?? '';
    } else {
      throw Exception('Failed to generate image: \n${response.body}');
    }
  }
}
