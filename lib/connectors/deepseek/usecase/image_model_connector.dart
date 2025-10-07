import 'package:gen_connect/repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/enums/models.dart';

final Set<DeepSeekModel> deepseekImageModels = {DeepSeekModel.deepseekVision};

class DeepSeekImageModelConnector implements AIModelConnector {
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekImageModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekImageModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${deepseekImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.DEEPSEEK.name;

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement DeepSeek image model API call
    return 'DeepSeek image response to: "$imagePath" | model: ${model.value}';
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
