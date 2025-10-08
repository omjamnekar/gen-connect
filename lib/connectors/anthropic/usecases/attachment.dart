import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicAttachmentUsecase {
  final String apiKey;
  final String model;
  AnthropicAttachmentUsecase({required this.apiKey, required this.model});

  Future<String> uploadAttachment(
    String attachmentBase64,
    String filename,
  ) async {
    final url = Uri.parse('https://api.anthropic.com/v1/upload-attachment');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': model,
        'attachment': attachmentBase64,
        'filename': filename,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['attachment_id'] ?? '';
    } else {
      throw Exception('Failed to upload attachment: \n${response.body}');
    }
  }
}
