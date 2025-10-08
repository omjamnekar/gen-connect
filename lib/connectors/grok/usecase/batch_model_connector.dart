import 'package:dio/dio.dart';
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class GrokBatchModelConnector {
  final String apiKey;
  final GrokModel model;
  final Dio _dio;

  GrokBatchModelConnector({required this.apiKey, required this.model})
    : _dio = GenConnectManager.dio;

  Future<String> batchRequest(List<String> prompts) async {
    try {
      final body = {'model': model.name, 'prompts': prompts};

      final response = await _dio.post(
        ApiConstants.grokBatchProcess,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to send batch request: ${response.statusCode} ${response.data}',
        );
      }
    } catch (e) {
      throw Exception('Error during batch request: $e');
    }
  }
}
