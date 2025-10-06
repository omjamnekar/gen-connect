import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';

final Set<GrokModel> grokTextModels = {
  GrokModel.grok2Mini,
  GrokModel.grok2_5,
  GrokModel.grok3,
  GrokModel.grok3Mini,
  GrokModel.grok4,
  GrokModel.grok4Heavy,
};

class GrokTextModelConnector implements AIModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokTextModelConnector({required this.apiKey, required this.model}) {
    if (!grokTextModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not text-capable. Allowed: ${grokTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GROK.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement Grok text model API call
      return 'Grok text response to: "$prompt" | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'Grok text model error',
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
