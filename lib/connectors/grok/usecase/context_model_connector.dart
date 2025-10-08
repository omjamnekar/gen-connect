import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/grok.dart';

import '../../../core/constants/api.dart';

class GrokContextModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final GrokModel model;

  GrokContextModelConnector({required this.apiKey, required this.model});

  Future<String> setContext(String context) async {
    final response = await _dio.post(
      ApiConstants.grokContextSet,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'model': model.name, 'context': context},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
        'Failed to set context: ${response.statusCode} ${response.data}',
      );
    }
  }
}
