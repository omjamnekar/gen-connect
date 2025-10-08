import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaContextModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaContextModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<String> getContext(
    String contextId, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'context_id': contextId,
        if (extraOptions != null) ...extraOptions,
      };

      final response = await _dio.post(
        ApiConstants.metaContextRetrieve,
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
        return data['context'] ?? '';
      } else {
        throw APIException(
          'Meta context error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta context model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
