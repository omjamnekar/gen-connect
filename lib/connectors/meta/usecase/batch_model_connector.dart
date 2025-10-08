import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaBatchModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaBatchModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<List<dynamic>> processBatch(
    List<Map<String, dynamic>> batchRequests, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'requests': batchRequests,
        if (extraOptions != null) ...extraOptions,
      };

      final response = await _dio.post(
        ApiConstants.metaBatchProcess,
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
        return data['results'] ?? [];
      } else {
        throw APIException(
          'Meta batch process error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta batch model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
