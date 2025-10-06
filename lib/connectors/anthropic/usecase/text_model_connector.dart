import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/anthropic.dart';

final Set<AnthropicModel> anthropicTextModels = {
  AnthropicModel.claudeInstant,
  AnthropicModel.claude2,
  AnthropicModel.claude3Opus,
  AnthropicModel.claude3Sonnet,
  AnthropicModel.claude3Haiku,
};

class AnthropicTextModelConnector implements AIModelConnector {
  final String apiKey;
  final AnthropicModel model;

  AnthropicTextModelConnector({required this.apiKey, required this.model}) {
    if (!anthropicTextModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not text-capable. Allowed: ${anthropicTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'Anthropic';

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement Anthropic text model API call
      return 'Anthropic text response to: "$prompt" | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'Anthropic text model error',
        innerException: e is Exception ? e : Exception(e.toString()),
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
