import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:dio/dio.dart';

class PalmAttachmentModelConnector {
  final String apiKey;
  final Dio _dio;

  PalmAttachmentModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> attachFile(String filePath) async {
    final uri = ApiConstants.palmAttachments;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });

    try {
      final response = await _dio.post(
        uri,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'Failed to attach file: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
