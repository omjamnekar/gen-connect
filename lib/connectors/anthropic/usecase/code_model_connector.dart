import 'package:gen_connect/repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/anthropic.dart';

final Set<AnthropicModel> anthropicCodeModels = {AnthropicModel.claude3Opus};

class AnthropicCodeModelConnector implements AIModelConnector {
  final String apiKey;
  final AnthropicModel model;

  AnthropicCodeModelConnector({required this.apiKey, required this.model}) {
    if (!anthropicCodeModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not code-capable. Allowed: ${anthropicCodeModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'Anthropic';

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Anthropic code model API call
    return 'Anthropic code response to: "$code" | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('Text input not supported for code models');

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
