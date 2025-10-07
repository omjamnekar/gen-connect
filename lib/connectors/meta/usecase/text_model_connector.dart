import 'package:gen_connect/repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/meta.dart';
import 'package:gen_connect/enums/models.dart';

final Set<MetaModel> metaTextModels = {
  MetaModel.llama2,
  MetaModel.llama3,
  MetaModel.llama3Large,
  MetaModel.llama3Medium,
  MetaModel.llama3Small,
};

class MetaTextModelConnector implements AIModelConnector {
  final String apiKey;
  final MetaModel model;

  MetaTextModelConnector({required this.apiKey, required this.model}) {
    if (!metaTextModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not text-capable. Allowed: ${metaTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.META.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement Meta text model API call
      return 'Meta text response to: "$prompt" | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'Meta text model error',
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
