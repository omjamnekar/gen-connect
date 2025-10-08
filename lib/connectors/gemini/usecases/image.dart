import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiImageUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiImageUsecase({required this.apiKey, required this.model});

  Future<String> generateImage(String prompt) async {
    final response = await _dio.post(
      ApiConstants.geminiGenerateImage(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'prompt': {'text': prompt},
        'imageSize': '1024x1024',
      },
    );
    if (response.statusCode == 200) {
      return response.data['imageUrl'] ?? '';
    } else {
      throw Exception('Failed to generate image: \n${response.data}');
    }
  }
}
