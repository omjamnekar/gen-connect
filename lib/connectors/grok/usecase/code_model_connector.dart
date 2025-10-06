import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';

final Set<GrokModel> grokCodeModels = {
  GrokModel.grokCodeFast1,
  GrokModel.grok4Fast,
};

class GrokCodeModelConnector implements AIModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokCodeModelConnector({required this.apiKey, required this.model}) {
    if (!grokCodeModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not code-capable. Allowed: ${grokCodeModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GROK.name;

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Grok code model API call
    return 'Grok code response to: "$code" | model: ${model.value}';
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
