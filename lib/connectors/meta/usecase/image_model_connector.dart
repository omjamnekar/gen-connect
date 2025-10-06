import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/meta.dart';
import 'package:gen_connect/enums/models.dart';

final Set<MetaModel> metaImageModels = {MetaModel.llama3Large};

class MetaImageModelConnector implements AIModelConnector {
  final String apiKey;
  final MetaModel model;

  MetaImageModelConnector({required this.apiKey, required this.model}) {
    if (!metaImageModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${metaImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.META.name;

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Meta image model API call
    return 'Meta image response to: "$imagePath" | model: ${model.value}';
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
