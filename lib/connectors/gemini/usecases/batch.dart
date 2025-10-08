import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/core/constants/api.dart';

class GeminiBatchUsecase {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  GeminiBatchUsecase({required this.apiKey, required this.model});

  Future<List<String>> batchGenerate(List<String> prompts) async {
    final response = await _dio.post(
      ApiConstants.geminiBatchGenerate(model),
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {'prompts': prompts, 'maxOutputTokens': 256},
    );
    if (response.statusCode == 200) {
      return List<String>.from(
        response.data['candidates']?.map((c) => c['output']) ?? [],
      );
    } else {
      throw Exception('Failed to batch generate: \n${response.data}');
    }
  }
}
