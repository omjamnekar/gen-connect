import 'package:dio/dio.dart';
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class GrokAttachmentModelConnector {
  final String apiKey;
  final GrokModel model;
  final Dio _dio;

  GrokAttachmentModelConnector({required this.apiKey, required this.model})
    : _dio = GenConnectManager.dio;

  Future<String> attachFile(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'model': model.name,
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        ApiConstants.grokAttachmentUpload,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to attach file: ${response.statusCode} ${response.data}',
        );
      }
    } catch (e) {
      throw Exception('Error during file attachment: $e');
    }
  }
}
