import 'package:gen_connect/repo/ai_model_connector.dart';
import 'package:gen_connect/enums/palm.dart';
import '../../../core/errors.dart';

final Set<PalmModel> palmCodeModels = {PalmModel.palm2Code};

class PalmCodeModelConnector implements AIModelConnector {
  final String apiKey;
  final PalmModel model;

  PalmCodeModelConnector({required this.apiKey, required this.model}) {
    if (!palmCodeModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not code-capable. Allowed: ${palmCodeModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'PaLM';

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement PaLM code model API call
    return 'PaLM code response to: "$code" | model: ${model.value}';
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
