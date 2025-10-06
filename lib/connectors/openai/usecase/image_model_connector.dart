import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'ai_model_connector.dart';
import '../../../core/errors.dart';

const Set<OpenAIModel> imageCapableModels = {OpenAIModel.gptImage1};

class OpenAIImageModelConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIImageModelConnector({required this.apiKey, required this.model}) {
    if (!imageCapableModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${imageCapableModels.map((m) => m.value).join(", ")}',
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
      throw AIConnectorError('Text input not supported for image models');

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('File upload not supported for image models');

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement image model API call
    return 'OpenAI Image response to: "$imagePath" | model: \\${model.value}';
  }

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
}
