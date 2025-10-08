import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicAttachmentUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicAttachmentUsecase({required this.apiKey, required this.model});

  Future<String> uploadAttachment(
    String attachmentBase64,
    String filename,
  ) async {
    final url = ApiConstants.anthropicUploadAttachment;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {
        'model': model,
        'attachment': attachmentBase64,
        'filename': filename,
      },
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['attachment_id'] ?? '';
    } else {
      throw Exception('Failed to upload attachment: \n${response.data}');
    }
  }
}
