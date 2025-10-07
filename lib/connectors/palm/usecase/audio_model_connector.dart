import 'dart:convert';
import 'package:http/http.dart' as http;

class PalmAudioModelConnector {
  final String apiKey;
  PalmAudioModelConnector({required this.apiKey});

  Future<String> sendAudioPrompt(
    String audioPath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // Replace with the actual Palm API endpoint for audio prompts
    final uri = Uri.parse('https://api.palm.com/v1/audio');

    // This assumes the API expects a base64 or file upload; adjust as needed
    final body = {
      'audio_path': audioPath,
      if (extraOptions != null) ...extraOptions,
    };

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to send audio prompt: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
