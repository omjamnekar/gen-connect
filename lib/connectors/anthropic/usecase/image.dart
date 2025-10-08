import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicImageUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicImageUsecase({required this.apiKey, required this.model});

  Future<String> generateImage(String prompt) async {
    final url = ApiConstants.anthropicGenerateImage;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'prompt': prompt, 'size': '1024x1024'},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['image_url'] ?? '';
    } else {
      throw Exception('Failed to generate image: \n${response.data}');
    }
  }
}
