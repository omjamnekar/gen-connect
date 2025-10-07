import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/deepseek.dart';

final Set<DeepSeekModel> deepseekTextModels = {
  DeepSeekModel.deepseekChat,
  DeepSeekModel.deepseekMath,
};

class DeepSeekTextModelConnector {
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekTextModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekTextModels.contains(model)) {
      throw Exception(
        'Model ${model.value} is not text-capable. Allowed: ${deepseekTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.deepseek.com/v1/text');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
    final body = {
      'model': model.value,
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (systemPrompt != null) 'system_prompt': systemPrompt,
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
      throw Exception('DeepSeek text API error: ${response.statusCode}');
    }
  }
}
