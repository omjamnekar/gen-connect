import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';

class ClaudeBatchModelConnector {
  final Dio dio;
  final String apiKey;
  final String apiVersion;

  ClaudeBatchModelConnector({
    required this.dio,
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<List<Map<String, dynamic>>> sendBatchPrompts(
    List<Map<String, dynamic>> batchRequests,
    String modelName,
  ) async {
    final url = ApiConstants.claudeBatch;
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
    };
    final body = {'model': modelName, 'requests': batchRequests};
    final response = await dio.post(
      url,
      options: Options(headers: headers),
      data: body,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return List<Map<String, dynamic>>.from(data['responses'] ?? []);
    } else {
      throw Exception('Claude Batch API error: ${response.statusCode}');
    }
  }
}
