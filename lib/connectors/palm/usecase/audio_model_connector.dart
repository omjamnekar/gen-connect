import 'package:gen_connect/gen_manager.dart';
import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';

class PalmAudioModelConnector {
  final String apiKey;
  final Dio _dio;

  PalmAudioModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> sendAudioPrompt(
    String audioPath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final uri = ApiConstants.palmAudio;

    final body = {
      'audio_path': audioPath,
      if (extraOptions != null) ...extraOptions,
    };

    try {
      final response = await _dio.post(
        uri,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'Failed to send audio prompt: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
