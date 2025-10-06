import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'ai_model_connector.dart';
import '../../../core/errors.dart';

final Set<OpenAIModel> audioCapableModels = {
  // Add actual audio-capable models here when available, e.g. OpenAIModel.gptAudio1
};

class OpenAIAudioModelConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIAudioModelConnector({required this.apiKey, required this.model}) {
    if (!audioCapableModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${audioCapableModels.map((m) => m.value).join(", ")}',
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
  }) async =>
      throw AIConnectorError('Text input not supported for audio models');

  // Implement required abstract methods
  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('File upload not supported for audio models');

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

  // Audio-specific method (not part of interface, but for demonstration)
  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement audio model API call
    return 'OpenAI Audio response to: "$audioPath" | model: ${model.value}';
  }
}
