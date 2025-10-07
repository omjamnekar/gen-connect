import 'package:gen_connect/connectors/claude/usecase/chat_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/streaming_model_connector.dart';
import 'package:gen_connect/enums/claude.dart';

import 'package:gen_connect/connectors/claude/usecase/tool_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/attachment_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/batch_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/token_count_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/context_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/service_tier_model_connector.dart';

class ClaudeV3 {
  final CloudeChatModelConnector chatConnector;
  final ClaudeStreamingModelConnector streamingConnector;
  final ClaudeToolModelConnector toolConnector;
  final ClaudeAttachmentModelConnector attachmentConnector;
  final ClaudeBatchModelConnector batchConnector;
  final ClaudeTokenCountModelConnector tokenCountConnector;
  final ClaudeContextModelConnector contextConnector;
  final ClaudeServiceTierModelConnector serviceTierConnector;

  ClaudeV3({
    required this.chatConnector,
    required this.streamingConnector,
    required this.toolConnector,
    required this.attachmentConnector,
    required this.batchConnector,
    required this.tokenCountConnector,
    required this.contextConnector,
    required this.serviceTierConnector,
  });
  Future<Map<String, dynamic>> Function(
    String prompt,
    Map<String, dynamic> contextManagement, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
  })
  get sendContextManagedPrompt =>
      (
        String prompt,
        Map<String, dynamic> contextManagement, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
        String? systemPrompt,
        List<Map<String, dynamic>>? messages,
      }) {
        return contextConnector.sendContextManagedPrompt(
          prompt,
          ClaudeModel.claudeV3.name,
          contextManagement: contextManagement,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
          systemPrompt: systemPrompt,
          messages: messages,
        );
      };

  Future<Map<String, dynamic>> Function(
    String prompt, {
    String serviceTier,
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
  })
  get sendServiceTierPrompt =>
      (
        String prompt, {
        String serviceTier = 'auto',
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
        String? systemPrompt,
        List<Map<String, dynamic>>? messages,
      }) {
        return serviceTierConnector.sendServiceTierPrompt(
          prompt,
          ClaudeModel.claudeV3.name,
          serviceTier: serviceTier,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
          systemPrompt: systemPrompt,
          messages: messages,
        );
      };

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
          ClaudeModel.claudeV3,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
        );
      };

  Stream<String> Function(
    String prompt, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
  })
  get streamChatPrompt =>
      (
        String prompt, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
        String? systemPrompt,
        List<Map<String, dynamic>>? messages,
      }) {
        return streamingConnector.streamChatPrompt(
          prompt,
          ClaudeModel.claudeV3.name,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
          systemPrompt: systemPrompt,
          messages: messages,
        );
      };

  Future<Map<String, dynamic>> Function(
    String prompt,
    List<Map<String, dynamic>> tools, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
    String? toolChoice,
  })
  get sendToolPrompt =>
      (
        String prompt,
        List<Map<String, dynamic>> tools, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
        String? systemPrompt,
        List<Map<String, dynamic>>? messages,
        String? toolChoice,
      }) {
        return toolConnector.sendToolPrompt(
          prompt,
          ClaudeModel.claudeV3.name,
          tools: tools,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
          systemPrompt: systemPrompt,
          messages: messages,
          toolChoice: toolChoice,
        );
      };

  Future<Map<String, dynamic>> Function(
    String prompt,
    List<Map<String, dynamic>> attachments, {
    Map<String, dynamic>? extraOptions,
    int? maxTokens,
    double? temperature,
    String? systemPrompt,
    List<Map<String, dynamic>>? messages,
  })
  get sendAttachmentPrompt =>
      (
        String prompt,
        List<Map<String, dynamic>> attachments, {
        Map<String, dynamic>? extraOptions,
        int? maxTokens,
        double? temperature,
        String? systemPrompt,
        List<Map<String, dynamic>>? messages,
      }) {
        return attachmentConnector.sendAttachmentPrompt(
          prompt,
          ClaudeModel.claudeV3.name,
          attachments: attachments,
          extraOptions: extraOptions,
          maxTokens: maxTokens,
          temperature: temperature,
          systemPrompt: systemPrompt,
          messages: messages,
        );
      };

  Future<List<Map<String, dynamic>>> Function(
    List<Map<String, dynamic>> batchRequests,
  )
  get sendBatchPrompts => (List<Map<String, dynamic>> batchRequests) {
    return batchConnector.sendBatchPrompts(
      batchRequests,
      ClaudeModel.claudeV3.name,
    );
  };

  Future<int> Function(String prompt) get countTokens => (String prompt) {
    return tokenCountConnector.countTokens(prompt, ClaudeModel.claudeV3.name);
  };

  String get name => ClaudeModel.claudeV3.name;
}
