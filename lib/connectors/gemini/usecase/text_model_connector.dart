import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../openai/usecase/ai_model_connector.dart';

final Set<GeminiModel> geminiTextModels = {
  GeminiModel.gemini2_5Pro,
  GeminiModel.gemini2_5Flash,
  GeminiModel.gemini2_5FlashLite,
  GeminiModel.gemini2_5FlashLitePreview,
  GeminiModel.gemini2_5FlashLive,
  GeminiModel.gemini2_0Flash,
  GeminiModel.gemini2_0FlashLite,
  GeminiModel.gemini2_0FlashLitePreview,
};

class GeminiTextModelConnector implements AIModelConnector {
  final String apiKey;
  final GeminiModel model;

  GeminiTextModelConnector({required this.apiKey, required this.model}) {
    if (!geminiTextModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not text-capable. Allowed: ${geminiTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GEMINI.name;

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
      'contents': [
        {
          'parts': [
            {'text': prompt},
          ],
        },
      ],
      if (temperature != null) 'generationConfig': {'temperature': temperature},
      if (maxTokens != null) 'generationConfig': {'maxOutputTokens': maxTokens},
      if (systemPrompt != null) 'systemInstruction': systemPrompt,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
    } else {
      throw Exception(
        'Gemini API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('File upload not supported');

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Image input not supported');

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Document upload not supported');
}
