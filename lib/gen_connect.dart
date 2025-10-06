import 'connectors/openai/usecase/ai_model_connector.dart';
// ...existing code...
import 'package:gen_connect/enums/models.dart';

/// Manager to handle multiple model connectors and configuration.
class GenConnectManager {
  final Map<String, AIModelConnector> _connectors = {};

  void addConnector(AIModelConnector connector) {
    _connectors[connector.name] = connector;
  }

  AIModelConnector? getConnector(Models model) => _connectors[model.name];

  Future<String?> sendPrompt(
    String modelName,
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final connector = _connectors[modelName];
    if (connector == null) return null;
    return await connector.sendPrompt(
      prompt,
      temperature: temperature,
      maxTokens: maxTokens,
      systemPrompt: systemPrompt,
      extraOptions: extraOptions,
    );
  }

  Future<String?> sendFile(
    String modelName,
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final connector = _connectors[modelName];
    if (connector == null) return null;
    return await connector.sendFile(
      filePath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }

  Future<String?> sendImage(
    String modelName,
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final connector = _connectors[modelName];
    if (connector == null) return null;
    return await connector.sendImage(
      imagePath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }

  Future<String?> sendDocument(
    String modelName,
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final connector = _connectors[modelName];
    if (connector == null) return null;
    return await connector.sendDocument(
      documentPath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }

  List<String> get availableModels => _connectors.keys.toList();
}
