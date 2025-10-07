import 'package:gen_connect/repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/enums/models.dart';

final Set<DeepSeekModel> deepseekTextModels = {
  DeepSeekModel.deepseekChat,
  DeepSeekModel.deepseekMath,
};

class DeepSeekTextModelConnector implements AIModelConnector {
  final String apiKey;
  final DeepSeekModel model;

  DeepSeekTextModelConnector({required this.apiKey, required this.model}) {
    if (!deepseekTextModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not text-capable. Allowed: ${deepseekTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.DEEPSEEK.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement DeepSeek text model API call
      return 'DeepSeek text response to: "$prompt" | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'DeepSeek text model error',
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
