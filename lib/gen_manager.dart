import 'package:gen_connect/connectors/cloude/coude_connector.dart';
import 'package:gen_connect/connectors/openai/openai_connector.dart';

import 'repo/ai_model_connector.dart';
// ...existing code...
import 'package:gen_connect/enums/models.dart';

class GenConnectManager {
  static final GenConnectManager _instance = GenConnectManager._insternal();
  final Map<String, AIModelConnector> _connectors = {};

  GenConnectManager._insternal();

  static GenConnectManager getInstance() => _instance;

  void addConnector(AIModelConnector connector) {
    if (connector is OpenAIConnector) {
      _connectors[Models.OPENAI.name] = connector;
    }
  }

  OpenAIConnector? get openai =>
      _connectors[Models.OPENAI.name] as OpenAIConnector?;
  CoudeConnector? get cloude =>
      _connectors[Models.CLAUDE.name] as CoudeConnector?;

  List<String> get availableOpenAIModels => _connectors.keys.toList();
}
