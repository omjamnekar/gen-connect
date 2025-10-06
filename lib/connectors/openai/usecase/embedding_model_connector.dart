import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'ai_model_connector.dart';

const Set<OpenAIModel> embeddingCapableModels = {
  OpenAIModel.textEmbeddingAda002,
};

class OpenAIEmbeddingModelConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIEmbeddingModelConnector({required this.apiKey, required this.model}) {
    if (!embeddingCapableModels.contains(model)) {
      throw ArgumentError(
        'Model \\${model.value} is not embedding-capable. Allowed: \\${embeddingCapableModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.OPENAI.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError();

  // Embedding-specific method (not part of interface, but for demonstration)
  Future<List<double>> embedText(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement embedding model API call
    return [0.0];
  }
}
