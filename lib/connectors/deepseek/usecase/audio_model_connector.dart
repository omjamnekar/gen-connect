import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/deepseek.dart';

class DeepSeekAudioModelConnector {
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekAudioModelConnector({required this.apiKey, required this.model});

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.deepseek.com/v1/audio');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
    final body = {
      'model': model.value,
      'audio_path': audioPath,
      if (prompt != null) 'prompt': prompt,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'] ?? '';
    } else {
      throw Exception('DeepSeek audio API error: ${response.statusCode}');
    }
  }
}
