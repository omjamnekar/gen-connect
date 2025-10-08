import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicContextUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicContextUsecase({required this.apiKey, required this.model});

  Future<String> getContext(String contextId) async {
    final url = ApiConstants.anthropicContext;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'context_id': contextId},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['context'] ?? '';
    } else {
      throw Exception('Failed to get context: \n${response.data}');
    }
  }
}
