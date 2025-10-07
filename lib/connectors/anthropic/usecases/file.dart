import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicFileUsecase {
  final String apiKey;
  final String model;
  AnthropicFileUsecase({required this.apiKey, required this.model});

  Future<String> uploadFile(String fileBase64, String filename) async {
    final url = Uri.parse('https://api.anthropic.com/v1/upload-file');
    final response = await http.post(
      url,
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'file': fileBase64,
        'filename': filename,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['file_id'] ?? '';
    } else {
      throw Exception('Failed to upload file: \n${response.body}');
    }
  }
}
