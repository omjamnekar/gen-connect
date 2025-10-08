import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';

class ClaudeTokenCountModelConnector {
  final Dio dio;
  final String apiKey;
  final String apiVersion;

  ClaudeTokenCountModelConnector({
    required this.dio,
    required this.apiKey,
    this.apiVersion = '2023-06-01',
  });

  Future<int> countTokens(String prompt, String modelName) async {
    final url = ApiConstants.claudeTokenCount;
    final headers = {
      'x-api-key': apiKey,
      'anthropic-version': apiVersion,
      'content-type': 'application/json',
    };
    final body = {'model': modelName, 'prompt': prompt};
    final response = await dio.post(
      url,
      options: Options(headers: headers),
      data: body,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['token_count'] ?? 0;
    } else {
      throw Exception('Claude Token Count API error: ${response.statusCode}');
    }
  }
}
