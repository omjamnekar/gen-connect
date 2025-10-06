import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
import '../../openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';

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

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement audio upload for supported models
      return 'Gemini audio upload: $audioPath | prompt: $prompt | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'Failed to send audio',
        innerException: e is Exception ? e : Exception(e.toString()),
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
