import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiAudioUsecase {
  final String apiKey;
  final String model;
  GeminiAudioUsecase({required this.apiKey, required this.model});

  Future<String> transcribeAudio(String audioBase64) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:transcribeAudio',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'audio': audioBase64}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['transcription'] ?? '';
    } else {
      throw Exception('Failed to transcribe audio: \n${response.body}');
    }
  }
}
