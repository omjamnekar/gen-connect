import 'package:gen_connect/connectors/openai/usecase/open_weight_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class Gptoss120b {
  OpenAIOpenWeightModelConnector openAIOpenWeightModelConnector;
  Gptoss120b({required this.openAIOpenWeightModelConnector});

  Future<String> Function(
    String prompt, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    String? systemPrompt,
    double? temperature,
  })
  get sendChatPrompt => openAIOpenWeightModelConnector.sendChatPrompt;

  Future<String> Function(
    String prompt, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
  })
  get sendCompletionPrompt =>
      openAIOpenWeightModelConnector.sendCompletionPrompt;

  String get name => OpenAIModel.gptOss120b.name;
}
