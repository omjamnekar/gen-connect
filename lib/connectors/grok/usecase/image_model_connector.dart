import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';

final Set<GrokModel> grokImageModels = {GrokModel.grok4, GrokModel.grok4Heavy};

class GrokImageModelConnector implements AIModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokImageModelConnector({required this.apiKey, required this.model}) {
    if (!grokImageModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${grokImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GROK.name;

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Grok image model API call
    return 'Grok image response to: "$imagePath" | model: ${model.value}';
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
