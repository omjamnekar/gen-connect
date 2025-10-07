import 'dart:convert';
import 'dart:io';
import 'package:gen_connect/core/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../repo/ai_model_connector.dart';

final Set<GeminiModel> geminiImageModels = {
  GeminiModel.gemini2_5Pro,
  GeminiModel.gemini2_5Flash,
};

class GeminiImageModelConnector implements AIModelConnector {
  final String apiKey;
  final GeminiModel model;

  GeminiImageModelConnector({required this.apiKey, required this.model}) {
    if (!geminiImageModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not image-capable. Allowed: ${geminiImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GEMINI.name;

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getGeminiImageCall(model, apiKey));
    final request = http.MultipartRequest('POST', url)
      ..fields['prompt'] = prompt ?? ''
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw HttpException(
        'Failed to send image: ${response.statusCode} $responseBody',
      );
    }
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getGeminicall(model, apiKey));
    final body = {
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (systemPrompt != null) 'system_prompt': systemPrompt,
      if (extraOptions != null) ...extraOptions,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw HttpException(
        'Failed to send prompt: ${response.statusCode} ${response.body}',
      );
    }
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getGeminiFileCall(model, apiKey));
    final request = http.MultipartRequest('POST', url)
      ..fields['prompt'] = prompt ?? ''
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw HttpException(
        'Failed to send file: ${response.statusCode} $responseBody',
      );
    }
  }

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getGeminiDocumentCall(model, apiKey));
    final request = http.MultipartRequest('POST', url)
      ..fields['prompt'] = prompt ?? ''
      ..files.add(await http.MultipartFile.fromPath('document', documentPath));

    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw HttpException(
        'Failed to send document: ${response.statusCode} $responseBody',
      );
    }
  }
}
