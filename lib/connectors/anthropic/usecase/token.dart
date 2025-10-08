import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicTokenUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicTokenUsecase({required this.apiKey, required this.model});

  Future<int> countTokens(String text) async {
    final url = ApiConstants.anthropicTokenize;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'input': text},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['token_count'] ?? 0;
    } else {
      throw Exception('Failed to count tokens: \n${response.data}');
    }
  }
}
