import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaImageModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaImageModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> generateImage(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      };

      final response = await _dio.post(
        ApiConstants.metaImageGenerate,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['image_url'] ?? '';
      } else {
        throw APIException(
          'Meta image generation error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta image model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
