import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicTierUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicTierUsecase({required this.apiKey, required this.model});

  Future<String> getTier() async {
    final url = ApiConstants.anthropicTier;
    final response = await dio.get(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['tier'] ?? '';
    } else {
      throw Exception('Failed to get tier: \n${response.data}');
    }
  }
}
