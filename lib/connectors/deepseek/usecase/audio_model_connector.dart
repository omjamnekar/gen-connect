import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/core/constants/api.dart';

class DeepSeekAudioModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekAudioModelConnector({required this.apiKey, required this.model});

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final response = await _dio.post(
      ApiConstants.deepSeekAudio,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': model.value,
        'audio_path': audioPath,
        if (prompt != null) 'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      },
    );
    if (response.statusCode == 200) {
      return response.data['result'] ?? '';
    } else {
      throw Exception('Failed to send audio: \n${response.data}');
    }
  }
}
