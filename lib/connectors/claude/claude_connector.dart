import 'package:gen_connect/connectors/claude/models/claude_v1.dart';
import 'package:gen_connect/connectors/claude/models/claude_v2.dart';
import 'package:gen_connect/connectors/claude/models/cluade_v3.dart';
import 'package:gen_connect/connectors/claude/usecase/attachment_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/batch_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/chat_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/streaming_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/token_count_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/tool_model_connector.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/repo/ai_model_connector.dart';

import 'package:gen_connect/connectors/claude/usecase/context_model_connector.dart';
import 'package:gen_connect/connectors/claude/usecase/service_tier_model_connector.dart';

class ClaudeConnector extends AIModelConnector {
  final String apiKey;
  final String apiVersion;
  late ClaudeToolModelConnector _claudeToolModelConnector;
  late ClaudeAttachmentModelConnector _claudeattachmentconnector;
  late CloudeChatModelConnector _chatModelConnector;
  late ClaudeTokenCountModelConnector _claudeTokenConnetor;
  late ClaudeStreamingModelConnector _claudeStreamingModelConnector;
  late ClaudeBatchModelConnector _claudeBatchModelConnector;
  late ClaudeContextModelConnector _claudeContextConnector;
  late ClaudeServiceTierModelConnector _claudeServiceTierConnector;

  ClaudeConnector({required this.apiKey, required this.apiVersion}) {
    final dio = GenConnectManager.dio;
    _chatModelConnector = CloudeChatModelConnector(
      dio: dio,
      apiKey: apiKey,
      apiVersion: apiVersion,
    );
    _claudeTokenConnetor = ClaudeTokenCountModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
    _claudeBatchModelConnector = ClaudeBatchModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
    _claudeStreamingModelConnector = ClaudeStreamingModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
    _claudeToolModelConnector = ClaudeToolModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
    _claudeattachmentconnector = ClaudeAttachmentModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
    _claudeContextConnector = ClaudeContextModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
    _claudeServiceTierConnector = ClaudeServiceTierModelConnector(
      dio: dio,
      apiKey: apiKey,
    );
  }

  ClaudeV1 get claudev1 => ClaudeV1(chatConnector: _chatModelConnector);
  ClaudeV2 get claudev2 => ClaudeV2(chatConnector: _chatModelConnector);
  ClaudeV3 get claudev3 => ClaudeV3(
    attachmentConnector: _claudeattachmentconnector,
    batchConnector: _claudeBatchModelConnector,
    tokenCountConnector: _claudeTokenConnetor,
    toolConnector: _claudeToolModelConnector,
    chatConnector: _chatModelConnector,
    streamingConnector: _claudeStreamingModelConnector,
    contextConnector: _claudeContextConnector,
    serviceTierConnector: _claudeServiceTierConnector,
  );

  @override
  Models get name => Models.CLAUDE;
}
