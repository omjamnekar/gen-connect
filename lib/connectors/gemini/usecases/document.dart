import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiDocumentUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiDocumentUsecase({required this.apiKey, required this.model});

  Future<String> uploadDocument(String documentBase64, String filename) async {
    final response = await _dio.post(
      ApiConstants.geminiUploadDocument(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'document': documentBase64, 'filename': filename},
    );
    if (response.statusCode == 200) {
      return response.data['documentId'] ?? '';
    } else {
      throw Exception('Failed to upload document: \n${response.data}');
    }
  }
}
