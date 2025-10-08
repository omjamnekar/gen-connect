import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiAttachmentUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiAttachmentUsecase({required this.apiKey, required this.model});

  Future<String> uploadAttachment(
    String attachmentBase64,
    String filename,
  ) async {
    final response = await _dio.post(
      ApiConstants.geminiUploadAttachment(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'attachment': attachmentBase64, 'filename': filename},
    );
    if (response.statusCode == 200) {
      return response.data['attachmentId'] ?? '';
    } else {
      throw Exception('Failed to upload attachment: \n${response.data}');
    }
  }
}
