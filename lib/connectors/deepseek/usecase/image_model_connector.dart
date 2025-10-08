import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<DeepSeekModel> deepseekImageModels = {DeepSeekModel.deepseekVision};

class DeepSeekImageModelConnector {
  final Dio _dio = GenConnectManager.dio;
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekImageModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekImageModels.contains(model)) {
      throw Exception(
        'Model ${model.value} is not image-capable. Allowed: ${deepseekImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final response = await _dio.post(
      ApiConstants.deepSeekImage,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': model.value,
        'image_path': imagePath,
        if (prompt != null) 'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      },
    );
    if (response.statusCode == 200) {
      return response.data['result'] ?? '';
    } else {
      throw Exception('Failed to send image: \n${response.data}');
    }
  }
}
