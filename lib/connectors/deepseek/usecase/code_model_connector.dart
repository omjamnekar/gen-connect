import 'package:gen_connect/repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/enums/models.dart';

final Set<DeepSeekModel> deepseekCodeModels = {DeepSeekModel.deepseekCoder};

class DeepSeekCodeModelConnector implements AIModelConnector {
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekCodeModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekCodeModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not code-capable. Allowed: ${deepseekCodeModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.DEEPSEEK.name;

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement DeepSeek code model API call
    return 'DeepSeek code response to: "$code" | model: ${model.value}';
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
