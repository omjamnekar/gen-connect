import 'package:dio/dio.dart';
import '../../../core/errors.dart';
import '../../../core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaCodeModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaCodeModelConnector({required this.apiKey}) : _dio = GenConnectManager.dio;

  Future<String> generateCode(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      };

      final response = await _dio.post(
        ApiConstants.metaCodeGenerate,
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
        return data['code'] ?? '';
      } else {
        throw APIException(
          'Meta code generation error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta code model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
