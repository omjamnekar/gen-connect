import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/anthropic.dart';

final Set<AnthropicModel> anthropicImageModels = {AnthropicModel.claude3Opus};

class AnthropicImageModelConnector implements AIModelConnector {
  final String apiKey;
  final AnthropicModel model;

  AnthropicImageModelConnector({required this.apiKey, required this.model}) {
    if (!anthropicImageModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${anthropicImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'Anthropic';

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Anthropic image model API call
    return 'Anthropic image response to: "$imagePath" | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('Text input not supported for image models');

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
