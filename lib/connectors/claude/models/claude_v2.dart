import 'package:gen_connect/connectors/claude/usecase/chat_model_connector.dart';
import 'package:gen_connect/enums/claude.dart';

class ClaudeV2 {
  final CloudeChatModelConnector chatConnector;
  ClaudeV2({required this.chatConnector});

  Future<String> Function(
    String prompt, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
  })
  get sendChatPrompt =>
      (
        String prompt, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
      }) {
        return chatConnector.sendChatPrompt(
          prompt,
          ClaudeModel.claudeV2,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
        );
      };

  String get name => ClaudeModel.claudeV2.name;
}
