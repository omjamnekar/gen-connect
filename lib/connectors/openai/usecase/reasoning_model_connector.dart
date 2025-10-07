import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<OpenAIModel> reasoningCapableModels = {
  OpenAIModel.o3,
  OpenAIModel.o3Mini,
  OpenAIModel.o3Pro,
  OpenAIModel.o4Mini,
};

class OpenAIReasoningModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIReasoningModelConnector({required this.apiKey, required this.model}) {
    if (!reasoningCapableModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not reasoning-capable. Allowed: ${reasoningCapableModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  // @override
  String get name => Models.OPENAI.name;

  // @override
  Future<String> sendPromptReasoning(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIChatCompletions());
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

  Future<String> sendImageReasoning(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIImageGenerations());
    final body = {
      'model': model.value,
      'prompt': prompt ?? '',
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'OpenAI Reasoning image API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<String> sendDocumentReasoning(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // OpenAI does not have a direct document endpoint; treat as file upload
    final url = Uri.parse(ApiConstants.getOpenAIFiles());
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('file', documentPath));
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'OpenAI Reasoning file API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
