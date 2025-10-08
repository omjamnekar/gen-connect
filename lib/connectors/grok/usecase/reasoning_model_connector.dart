import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/grok.dart';

import '../../../core/constants/api.dart';

class GrokReasoningModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final GrokModel model;

  GrokReasoningModelConnector({required this.apiKey, required this.model});

  Future<String> reason(String prompt) async {
    final response = await _dio.post(
      ApiConstants.grokReasoningAnalyze,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'model': model.name, 'prompt': prompt},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
        'Failed to get reasoning: ${response.statusCode} ${response.data}',
      );
    }
  }
}
