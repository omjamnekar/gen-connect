import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaReasoningModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaReasoningModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> runReasoning(
    String input, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {'input': input, if (extraOptions != null) ...extraOptions};

      final response = await _dio.post(
        ApiConstants.metaReasoningAnalyze,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['result'] ?? '';
      } else {
        throw APIException(
          'Meta reasoning error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta reasoning model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
