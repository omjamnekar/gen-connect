import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiAttachmentUsecase {
  final String apiKey;
  final String model;
  GeminiAttachmentUsecase({required this.apiKey, required this.model});

  Future<String> uploadAttachment(
    String attachmentBase64,
    String filename,
  ) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:uploadAttachment',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'attachment': attachmentBase64, 'filename': filename}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['attachmentId'] ?? '';
    } else {
      throw Exception('Failed to upload attachment: \n${response.body}');
    }
  }
}
