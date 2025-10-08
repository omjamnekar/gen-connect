import 'package:dio/dio.dart';
import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

final Set<GrokModel> grokAudioModels = {GrokModel.grok4};

class GrokAudioModelConnector {
  final String apiKey;
  final GrokModel model;
  final Dio _dio;

  GrokAudioModelConnector({required this.apiKey, required this.model})
    : _dio = GenConnectManager.dio {
    if (!grokAudioModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${grokAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  String get name => Models.GROK.name;

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(audioPath),
        if (prompt != null) 'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      });

      final response = await _dio.post(
        ApiConstants.grokAudioTranscriptions,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Grok audio API error: ${response.statusCode} ${response.data}',
        );
      }
    } catch (e) {
      throw Exception('Error during audio API call: $e');
    }
  }
}
