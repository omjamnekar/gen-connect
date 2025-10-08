import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiAudioUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiAudioUsecase({required this.apiKey, required this.model});

  Future<String> transcribeAudio(String audioBase64) async {
    final response = await _dio.post(
      ApiConstants.geminiTranscribeAudio(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'audio': audioBase64},
    );
    if (response.statusCode == 200) {
      return response.data['transcription'] ?? '';
    } else {
      throw Exception('Failed to transcribe audio: \n${response.data}');
    }
  }
}
