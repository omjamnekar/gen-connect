import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiFileUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiFileUsecase({required this.apiKey, required this.model});

  Future<String> uploadFile(String fileBase64, String filename) async {
    final response = await _dio.post(
      ApiConstants.geminiUploadFile(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'file': fileBase64, 'filename': filename},
    );
    if (response.statusCode == 200) {
      return response.data['fileId'] ?? '';
    } else {
      throw Exception('Failed to upload file: \n${response.data}');
    }
  }
}
