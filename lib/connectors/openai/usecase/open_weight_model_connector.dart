import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/openai.dart';

import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final List<OpenAIModel> openWeightCapableModels = [
  OpenAIModel.gptOss120b,
  OpenAIModel.gptOss20b,
  // Add other open-weight-capable models here as needed
];

class OpenAIOpenWeightModelConnector {
  final String apiKey;

  OpenAIOpenWeightModelConnector({required this.apiKey});
  String get name => Models.OPENAI.name;

  Future<String> sendChatPrompt(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('${ApiConstants.openaiBaseUrl}/chat');
    final body = {
      'model': model.value,
      'messages': [
        if (systemPrompt != null) {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': prompt},
      ],
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices']?[0]?['message']?['content'] ?? '';
    } else {
      throw Exception(
        'OpenAI OpenWeight API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<String> sendCompletionPrompt(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('${ApiConstants.openaiBaseUrl}/completion');
    final body = {
      'model': model.value,
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices']?[0]?['text'] ?? '';
    } else {
      throw Exception(
        'OpenAI OpenWeight API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
