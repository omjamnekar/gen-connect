import 'package:gen_connect/connectors/openai/usecase/reasoning_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class O4mini {
  OpenAIReasoningModelConnector openAIReasoningModelConnector;
  O4mini({required this.openAIReasoningModelConnector});

  Future<String> Function(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendPromptReasoning => openAIReasoningModelConnector.sendPromptReasoning;

  Future<String> Function(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendImageReasoning => openAIReasoningModelConnector.sendImageReasoning;

  Future<String> Function(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendDocumentReasoning =>
      openAIReasoningModelConnector.sendDocumentReasoning;
  String get name => OpenAIModel.o4Mini.name;
}
