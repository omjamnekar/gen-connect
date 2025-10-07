import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

final Set<GeminiModel> geminiAudioModels = {GeminiModel.gemini2_5Pro};

class GeminiAudioModelConnector implements AIModelConnector {
  final String apiKey;
  final GeminiModel model;

  GeminiAudioModelConnector({required this.apiKey, required this.model}) {
    if (!geminiAudioModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${geminiAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GEMINI.name;

  Future<String> _sendMultipartRequest(
    String url, {
    Map<String, String>? fields,
    Map<String, String>? files,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $apiKey';

      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (files != null) {
        for (final entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value),
          );
        }
      }
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
        throw APIException(
          'Failed to send request: ${response.statusCode} $responseBody',
        );
      }
    } catch (e) {
      throw APIException(
        'Failed to send request',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  Future<String> _sendJsonRequest(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse(url);
      final mergedBody = <String, dynamic>{
        'model': model.value,
        if (body != null) ...body,
        if (extraOptions != null) ...extraOptions,
      };
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: mergedBody.isNotEmpty ? mergedBody.toString() : null,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw APIException(
          'Failed to send request: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw APIException(
        'Failed to send request',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getGeminiAudioCall(model, apiKey);
    return _sendMultipartRequest(
      url,
      fields: {'model': model.value, 'prompt': prompt ?? ''},
      files: {'audio': audioPath},
      extraOptions: extraOptions,
    );
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getGeminicall(model, apiKey);
    return _sendJsonRequest(
      url,
      body: {
        'prompt': prompt,
        if (temperature != null) 'temperature': temperature,
        if (maxTokens != null) 'max_tokens': maxTokens,
        if (systemPrompt != null) 'system_prompt': systemPrompt,
      },
      extraOptions: extraOptions,
    );
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getGeminiFileCall(model, apiKey);
    return _sendMultipartRequest(
      url,
      fields: {'model': model.value, 'prompt': prompt ?? ''},
      files: {'file': filePath},
      extraOptions: extraOptions,
    );
  }

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getGeminiImageCall(model, apiKey);
    return _sendMultipartRequest(
      url,
      fields: {'model': model.value, 'prompt': prompt ?? ''},
      files: {'image': imagePath},
      extraOptions: extraOptions,
    );
  }

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getGeminiDocumentCall(model, apiKey);
    return _sendMultipartRequest(
      url,
      fields: {'model': model.value, 'prompt': prompt ?? ''},
      files: {'document': documentPath},
      extraOptions: extraOptions,
    );
  }
}
