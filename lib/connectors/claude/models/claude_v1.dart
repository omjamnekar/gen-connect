import 'package:gen_connect/connectors/claude/usecase/chat_model_connector.dart';
import 'package:gen_connect/enums/claude.dart';

class ClaudeV1 {
  final CloudeChatModelConnector chatConnector;
  ClaudeV1({required this.chatConnector});

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
          ClaudeModel.claudeV1,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
        );
      };

  String get name => ClaudeModel.claudeV1.name;
}
