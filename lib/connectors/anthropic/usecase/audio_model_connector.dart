import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/anthropic.dart';

final Set<AnthropicModel> anthropicAudioModels = {AnthropicModel.claude3Opus};

class AnthropicAudioModelConnector implements AIModelConnector {
  final String apiKey;
  final AnthropicModel model;

  AnthropicAudioModelConnector({required this.apiKey, required this.model}) {
    if (!anthropicAudioModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${anthropicAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'Anthropic';

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Anthropic audio model API call
    return 'Anthropic audio response to: "$audioPath" | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('Text input not supported for audio models');

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
