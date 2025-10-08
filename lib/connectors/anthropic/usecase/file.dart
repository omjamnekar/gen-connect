import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicFileUsecase {
  Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicFileUsecase({required this.apiKey, required this.model});

  Future<String> uploadFile(String fileBase64, String filename) async {
    final url = ApiConstants.anthropicUploadFile;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'file': fileBase64, 'filename': filename},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['file_id'] ?? '';
    } else {
      throw Exception('Failed to upload file: \n${response.data}');
    }
  }
}
