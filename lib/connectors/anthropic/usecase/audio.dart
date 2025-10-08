import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicAudioUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicAudioUsecase({required this.apiKey, required this.model});

  Future<String> transcribeAudio(String audioBase64) async {
    final url = ApiConstants.anthropicTranscribeAudio;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'audio': audioBase64},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['transcription'] ?? '';
    } else {
      throw Exception('Failed to transcribe audio: \n${response.data}');
    }
  }
}
