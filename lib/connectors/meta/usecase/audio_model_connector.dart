import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';
import '../../../core/errors.dart';

class MetaAudioModelConnector {
  final Dio _dio;
  final String apiKey;

  MetaAudioModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> transcribeAudio(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        if (extraOptions != null) ...extraOptions,
      });

      final response = await _dio.post(
        ApiConstants.metaAudioTranscribe,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['transcript'] ?? '';
      } else {
        throw APIException(
          'Meta audio transcription error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta audio model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
