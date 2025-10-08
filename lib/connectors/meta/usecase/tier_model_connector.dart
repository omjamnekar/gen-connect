import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaTierModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaTierModelConnector({required this.apiKey}) : _dio = GenConnectManager.dio;

  Future<String> getTierInfo({Map<String, dynamic>? extraOptions}) async {
    try {
      final body = {if (extraOptions != null) ...extraOptions};

      final response = await _dio.post(
        ApiConstants.metaTierInfo,
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
        return data['tier'] ?? '';
      } else {
        throw APIException(
          'Meta tier info error: ${response.statusCode}',
          innerException: Exception(response.data.toString()),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta tier model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
