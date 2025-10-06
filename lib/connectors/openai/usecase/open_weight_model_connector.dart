import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'ai_model_connector.dart';

final Set<OpenAIModel> openWeightCapableModels = {
  OpenAIModel.gptOss120b,
  OpenAIModel.gptOss20b,
};

class OpenAIOpenWeightModelConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;
  final String endpoint;

  OpenAIOpenWeightModelConnector({
    required this.apiKey,
    required this.endpoint,
    required this.model,
  }) {
    if (!openWeightCapableModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not open-weight-capable. Allowed: ${openWeightCapableModels.map((m) => m.value).join(", ")}',
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
  }) async {
    // TODO: Implement open-weight API call
    return 'OpenAI OpenWeight response to: "$prompt" | model: ${model.value} | endpoint: $endpoint';
  }

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
}
