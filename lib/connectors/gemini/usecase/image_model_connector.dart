import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
// Removed unused imports
import '../../openai/usecase/ai_model_connector.dart';

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
    // TODO: Implement image upload for supported models
    return 'Gemini image upload: $imagePath | prompt: $prompt | model: ${model.value}';
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
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Document upload not supported');
}
