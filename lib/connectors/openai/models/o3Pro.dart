import 'package:gen_connect/connectors/openai/usecase/reasoning_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class O3Pro {
  OpenAIReasoningModelConnector openAIReasoningModelConnector;
  O3Pro({required this.openAIReasoningModelConnector});

  Future<String> Function(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendPromptReasoning =>
      (
        String prompt, {
        double? temperature,
        int? maxTokens,
        String? systemPrompt,
        Map<String, dynamic>? extraOptions,
      }) {
        return openAIReasoningModelConnector.sendPromptReasoning(
          prompt,
          OpenAIModel.o3Pro,
          temperature: temperature,
          maxTokens: maxTokens,
          systemPrompt: systemPrompt,
          extraOptions: extraOptions,
        );
      };

  Future<String> Function(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendImageReasoning =>
      (String imagePath, {String? prompt, Map<String, dynamic>? extraOptions}) {
        return openAIReasoningModelConnector.sendImageReasoning(
          imagePath,
          OpenAIModel.o3Pro,
          prompt: prompt,
          extraOptions: extraOptions,
        );
      };

  Future<String> Function(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendDocumentReasoning =>
      openAIReasoningModelConnector.sendDocumentReasoning;
  String get name => OpenAIModel.o3Pro.name;
}
