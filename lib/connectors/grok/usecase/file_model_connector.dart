import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';

class GrokFileModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final GrokModel model;

  GrokFileModelConnector({required this.apiKey, required this.model});

  Future<String> uploadFile(String filePath) async {
    final formData = FormData.fromMap({
      'model': model.name,
      'file': await MultipartFile.fromFile(filePath),
    });

    final response = await _dio.post(
      ApiConstants.grokFileUpload,
      options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
        'Failed to upload file: ${response.statusCode} ${response.data}',
      );
    }
  }
}
