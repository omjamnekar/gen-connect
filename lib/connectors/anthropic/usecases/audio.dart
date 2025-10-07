import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicAudioUsecase {
  final String apiKey;
  final String model;
  AnthropicAudioUsecase({required this.apiKey, required this.model});

  Future<String> transcribeAudio(String audioBase64) async {
    final url = Uri.parse('https://api.anthropic.com/v1/transcribe-audio');
    final response = await http.post(
      url,
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'audio': audioBase64,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['transcription'] ?? '';
    } else {
      throw Exception('Failed to transcribe audio: \n${response.body}');
    }
  }
}
