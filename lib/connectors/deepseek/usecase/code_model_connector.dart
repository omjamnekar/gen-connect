import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/deepseek.dart';

final Set<DeepSeekModel> deepseekCodeModels = {DeepSeekModel.deepseekCoder};

class DeepSeekCodeModelConnector {
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
    final url = Uri.parse('https://api.deepseek.com/v1/code');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
    final body = {
      'model': model.value,
      'code': code,
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
      throw Exception('DeepSeek code API error: ${response.statusCode}');
    }
  }
}
