import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/errors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api.dart';

const Set<OpenAIModel> imageCapableModels = {OpenAIModel.gptImage1};

class OpenAIImageModelConnector {
  final String apiKey;

  OpenAIImageModelConnector({required this.apiKey});

  String get name => Models.OPENAI.name;

  Future<String> sendPromptToImage(
    String prompt,
    OpenAIModel model, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIImageGenerations());
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
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw AIConnectorError(
        'OpenAI Image API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<String> sendImagetoImage(
    String imagePath,
    OpenAIModel model, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIImageGenerations());
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..fields['model'] = model.value;
    if (prompt != null) {
      request.fields['prompt'] = prompt;
    }
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw AIConnectorError(
        'OpenAI Image-to-Text API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
