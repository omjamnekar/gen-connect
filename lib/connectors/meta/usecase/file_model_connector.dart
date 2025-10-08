import 'package:dio/dio.dart';
import '../../../core/errors.dart';
import '../../../core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaFileModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaFileModelConnector({required this.apiKey}) : _dio = GenConnectManager.dio;

  Future<String> uploadFile(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        if (extraOptions != null) ...extraOptions,
      });

      final response = await _dio.post(
        ApiConstants.metaFileUpload,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['file_id'] ?? '';
      } else {
        throw APIException(
          'Meta file upload error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta file model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
