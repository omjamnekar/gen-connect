import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/repo/ai_model_connector.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final Set<GeminiModel> geminiVideoModels = {GeminiModel.gemini2_5Pro};

class GeminiVideoModelConnector implements AIModelConnector {
  final String apiKey;
  final GeminiModel model;

  GeminiVideoModelConnector({required this.apiKey, required this.model}) {
    if (!geminiVideoModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not video-capable. Allowed: ${geminiVideoModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GEMINI.name;

  Future<String> sendVideo(
    String videoPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getGeminiVideoCall(model, apiKey));
    final request = http.MultipartRequest('POST', url)
      ..fields['prompt'] = prompt ?? ''
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('video', videoPath));
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.toString();
    } else {
      throw Exception(
        'Gemini video API error: ${response.statusCode} ${response.body}',
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
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
    final body = {
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'maxTokens': maxTokens,
      if (systemPrompt != null) 'systemPrompt': systemPrompt,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.toString();
    } else {
      throw Exception(
        'Gemini text API error: ${response.statusCode} ${response.body}',
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
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.toString();
    } else {
      throw Exception(
        'Gemini file API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getGeminiImageCall(model, apiKey));
    final request = http.MultipartRequest('POST', url)
      ..fields['prompt'] = prompt ?? ''
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.toString();
    } else {
      throw Exception(
        'Gemini image API error: ${response.statusCode} ${response.body}',
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
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(
      await http.MultipartFile.fromPath('document', documentPath),
    );
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.toString();
    } else {
      throw Exception(
        'Gemini document API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
