import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ai_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';

final Set<OpenAIModel> reasoningCapableModels = {
  OpenAIModel.o3,
  OpenAIModel.o3Mini,
  OpenAIModel.o3Pro,
  OpenAIModel.o4Mini,
};

class OpenAIReasoningModelConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIReasoningModelConnector({required this.apiKey, required this.model}) {
    if (!reasoningCapableModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not reasoning-capable. Allowed: ${reasoningCapableModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.OPENAI.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
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
        'OpenAI Reasoning API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
}
