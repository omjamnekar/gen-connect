import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/deepseek.dart';

final Set<DeepSeekModel> deepseekImageModels = {DeepSeekModel.deepseekVision};

class DeepSeekImageModelConnector {
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
    final url = Uri.parse('https://api.deepseek.com/v1/image');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
    final body = {
      'model': model.value,
      'image_path': imagePath,
      if (prompt != null) 'prompt': prompt,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'] ?? '';
    } else {
      throw Exception('DeepSeek image API error: ${response.statusCode}');
    }
  }
}
