import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';

import '../../openai/usecase/ai_model_connector.dart';

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
    // TODO: Implement video upload for supported models
    return 'Gemini video upload: $videoPath | prompt: $prompt | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Text input not supported');

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
