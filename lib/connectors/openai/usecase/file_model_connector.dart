import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/openai.dart';

import '../../../core/constants/api.dart';

const Set<OpenAIModel> fileCapableModels = {
  OpenAIModel.gpt3_5Turbo,
  OpenAIModel.gpt4,
  OpenAIModel.gpt4_1,
  OpenAIModel.gpt4o,
};

class OpenAIFileModelConnector {
  final String apiKey;
  final Dio _dio;

  OpenAIFileModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> uploadFiletoText(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIFiles();
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      if (extraOptions != null) ...extraOptions,
    });

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'OpenAI file upload error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<String> deleteFile(String fileId) async {
    final url = '${ApiConstants.getOpenAIFiles()}/$fileId';

    try {
      final response = await _dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'OpenAI file delete error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<String> getFileInfo(String fileId) async {
    final url = '${ApiConstants.getOpenAIFiles()}/$fileId';

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'OpenAI get file info error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
