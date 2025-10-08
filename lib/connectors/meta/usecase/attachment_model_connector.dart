import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaAttachmentModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaAttachmentModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> uploadAttachment(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        if (extraOptions != null) ...extraOptions,
      });

      final response = await _dio.post(
        ApiConstants.metaAttachmentUpload,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['attachment_id'] ?? '';
      } else {
        throw APIException(
          'Meta attachment upload error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta attachment model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
