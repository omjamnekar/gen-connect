import 'package:dio/dio.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

class AnthropicToolUsecase {
  final Dio dio = GenConnectManager.dio;
  final String apiKey;
  final String model;
  AnthropicToolUsecase({required this.apiKey, required this.model});

  Future<String> runTool(String toolName, Map<String, dynamic> params) async {
    final url = ApiConstants.anthropicRunTool;
    final response = await dio.post(
      url,
      options: Options(
        headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      ),
      data: {'model': model, 'tool': toolName, 'params': params},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return data['result'] ?? '';
    } else {
      throw Exception('Failed to run tool: \n${response.data}');
    }
  }
}
