import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'ai_model_connector.dart';
import '../../../core/errors.dart';

const Set<OpenAIModel> chatCapableModels = {
  OpenAIModel.gpt3_5Turbo,
  OpenAIModel.gpt4,
  OpenAIModel.gpt4_1,
  OpenAIModel.gpt4o,
};

class OpenAIChatModelConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIChatModelConnector({required this.apiKey, required this.model}) {
    if (!chatCapableModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not chat-capable. Allowed: ${chatCapableModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.OPENAI.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // TODO: Implement chat/text API call
      return 'OpenAI Chat response to: "$prompt" | model: ${model.value}';
    } catch (e) {
      throw APIException(
        'OpenAI chat error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();
}
