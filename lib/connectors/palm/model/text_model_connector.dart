import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import 'package:gen_connect/enums/palm.dart';
import '../../../core/errors.dart';

final Set<PalmModel> palmTextModels = {
  PalmModel.palm,
  PalmModel.palm2,
  PalmModel.palm2Chat,
};

class PalmTextModelConnector implements AIModelConnector {
  final String apiKey;
  final PalmModel model;

  PalmTextModelConnector({required this.apiKey, required this.model}) {
    if (!palmTextModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not text-capable. Allowed: ${palmTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'PaLM';

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement PaLM text model API call
      return 'PaLM text response to: "$prompt" | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'PaLM text model error',
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
