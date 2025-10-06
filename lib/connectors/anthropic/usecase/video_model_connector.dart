import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/anthropic.dart';

final Set<AnthropicModel> anthropicVideoModels = {AnthropicModel.claude3Opus};

class AnthropicVideoModelConnector implements AIModelConnector {
  final String apiKey;
  final AnthropicModel model;

  AnthropicVideoModelConnector({required this.apiKey, required this.model}) {
    if (!anthropicVideoModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not video-capable. Allowed: ${anthropicVideoModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'Anthropic';

  Future<String> sendVideo(
    String videoPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Anthropic video model API call
    return 'Anthropic video response to: "$videoPath" | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('Text input not supported for video models');

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
