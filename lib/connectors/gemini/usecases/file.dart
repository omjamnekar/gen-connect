import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiFileUsecase {
  final String apiKey;
  final String model;
  GeminiFileUsecase({required this.apiKey, required this.model});

  Future<String> uploadFile(String fileBase64, String filename) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:uploadFile',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'file': fileBase64, 'filename': filename}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['fileId'] ?? '';
    } else {
      throw Exception('Failed to upload file: \n${response.body}');
    }
  }
}
