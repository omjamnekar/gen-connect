// ignore_for_file: file_names
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
  get sendChatPrompt =>
      (
        String prompt, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        String? systemPrompt,
        double? temperature,
      }) {
        return openAIOpenWeightModelConnector.sendChatPrompt(
          prompt,
          OpenAIModel.gptOss120b,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          systemPrompt: systemPrompt,
          temperature: temperature,
        );
      };

  Future<String> Function(
    String prompt, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
  })
  get sendCompletionPrompt =>
      (
        String prompt, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
      }) {
        return openAIOpenWeightModelConnector.sendCompletionPrompt(
          prompt,
          OpenAIModel.gptOss120b,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
        );
      };

  String get name => OpenAIModel.gptOss120b.name;
}
