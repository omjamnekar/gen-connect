import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import 'package:gen_connect/enums/palm.dart';
import '../../../core/errors.dart';

final Set<PalmModel> palmImageModels = {PalmModel.palm2Vision};

class PalmImageModelConnector implements AIModelConnector {
  final String apiKey;
  final PalmModel model;

  PalmImageModelConnector({required this.apiKey, required this.model}) {
    if (!palmImageModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${palmImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'PaLM';

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement PaLM image model API call
    return 'PaLM image response to: "$imagePath" | model: ${model.value}';
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
