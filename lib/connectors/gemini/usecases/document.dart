import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiDocumentUsecase {
  final String apiKey;
  final String model;
  GeminiDocumentUsecase({required this.apiKey, required this.model});

  Future<String> uploadDocument(String documentBase64, String filename) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:uploadDocument',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'document': documentBase64, 'filename': filename}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['documentId'] ?? '';
    } else {
      throw Exception('Failed to upload document: \n${response.body}');
    }
  }
}
