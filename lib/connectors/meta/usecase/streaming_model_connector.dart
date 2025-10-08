import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/gen_manager.dart';

class MetaStreamingModelConnector {
  final String apiKey;
  final Dio _dio;

  MetaStreamingModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  Future<Stream<String>> streamResponse(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      };

      final response = await _dio.post(
        ApiConstants.metaStreamingData,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.stream,
        ),
      );

      return response.data.stream.transform(utf8.decoder);
    } catch (e) {
      throw APIException(
        'Meta streaming model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
