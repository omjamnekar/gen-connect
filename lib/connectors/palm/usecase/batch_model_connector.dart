import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:dio/dio.dart';

class PalmBatchModelConnector {
  final String apiKey;
  final Dio _dio;

  PalmBatchModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> batchRequest(List<String> prompts) async {
    final uri = ApiConstants.palmBatch;

    final body = {'prompts': prompts};

    try {
      final response = await _dio.post(
        uri,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(
        'Failed to send batch request: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
