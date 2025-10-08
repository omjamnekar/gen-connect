import 'package:gen_connect/connectors/claude/claude_connector.dart';
import 'package:gen_connect/connectors/openai/openai_connector.dart';
import 'package:gen_connect/connectors/gemini/gemini_connector.dart';
import 'package:gen_connect/connectors/meta/meta_connector.dart';
import 'package:gen_connect/connectors/anthropic/anthropic_connector.dart';
import 'package:gen_connect/connectors/deepseek/deepseek_connector.dart';
import 'package:gen_connect/connectors/palm/palm_connector.dart';
import 'package:gen_connect/connectors/grok/grok_connector.dart';
import 'package:dio/dio.dart';
import 'package:gen_connect/core/api/dio_client.dart';

import 'repo/ai_model_connector.dart';
import 'package:gen_connect/enums/models.dart';

class GenConnectManager {
  static final GenConnectManager _instance = GenConnectManager._insternal();
  final Map<String, AIModelConnector> _connectors = {};

  static final Dio _dio = DioClient().client;

  GenConnectManager._insternal();

  static GenConnectManager getInstance() => _instance;

  void addConnector(AIModelConnector connector) {
    if (connector is OpenAIConnector) {
      _connectors[Models.OPENAI.name] = connector;
    } else if (connector is GeminiConnector) {
      _connectors[Models.GEMINI.name] = connector;
    } else if (connector is MetaConnector) {
      _connectors[Models.META.name] = connector;
    } else if (connector is AnthropicConnector) {
      _connectors[Models.CLAUDE.name] = connector;
    } else if (connector is DeepSeekConnector) {
      _connectors[Models.DEEPSEEK.name] = connector;
    } else if (connector is PalmConnector) {
      _connectors[Models.PALM.name] = connector;
    } else if (connector is GrokConnector) {
      _connectors[Models.GROK.name] = connector;
    } else if (connector is ClaudeConnector) {
      _connectors[Models.CLAUDE.name] = connector;
    }
  }

  OpenAIConnector? get openai =>
      _connectors[Models.OPENAI.name] as OpenAIConnector?;
  GeminiConnector? get gemini =>
      _connectors[Models.GEMINI.name] as GeminiConnector?;
  MetaConnector? get meta => _connectors[Models.META.name] as MetaConnector?;
  AnthropicConnector? get anthropic =>
      _connectors[Models.CLAUDE.name] as AnthropicConnector?;
  DeepSeekConnector? get deepseek =>
      _connectors[Models.DEEPSEEK.name] as DeepSeekConnector?;
  PalmConnector? get palm => _connectors[Models.PALM.name] as PalmConnector?;
  GrokConnector? get grok => _connectors[Models.GROK.name] as GrokConnector?;
  ClaudeConnector? get cloude =>
      _connectors[Models.CLAUDE.name] as ClaudeConnector?;

  List<String> get availableModels => _connectors.keys.toList();

  static Dio get dio => _dio;
}
