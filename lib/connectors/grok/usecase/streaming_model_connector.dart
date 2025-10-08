import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';

class GrokStreamingModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final GrokModel model;

  GrokStreamingModelConnector({required this.apiKey, required this.model});

  Stream<String> streamPrompt(String prompt) async* {
    final response = await _dio.request(
      ApiConstants.grokStreamingData,
      options: Options(
        method: 'POST',
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'model': model.name, 'prompt': prompt},
    );

    if (response.statusCode == 200) {
      yield* response.data.stream.transform(utf8.decoder);
    } else {
      throw Exception('Failed to stream prompt: ${response.statusCode}');
    }
  }
}
