import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<DeepSeekModel> deepseekCodeModels = {DeepSeekModel.deepseekCoder};

class DeepSeekCodeModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekCodeModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekCodeModels.contains(model)) {
      throw Exception(
        'Model ${model.value} is not code-capable. Allowed: ${deepseekCodeModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final response = await _dio.post(
      ApiConstants.deepSeekCode,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': model.value,
        'code': code,
        if (extraOptions != null) ...extraOptions,
      },
    );
    if (response.statusCode == 200) {
      return response.data['result'] ?? '';
    } else {
      throw Exception('Failed to send code: \n${response.data}');
    }
  }
}
