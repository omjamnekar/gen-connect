import 'package:gen_connect/enums/models.dart';
import '../openai/usecase/ai_model_connector.dart';

class AnthropicConnector implements AIModelConnector {
  final String apiKey;
  final String model;

  AnthropicConnector({required this.apiKey, this.model = 'claude-2'});

  @override
  String get name => Models.CLAUDE.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement actual API call with all options
    return 'Anthropic response to: "$prompt" | model: $model | temp: ${temperature ?? 'default'} | maxTokens: ${maxTokens ?? 'default'} | systemPrompt: ${systemPrompt ?? 'none'} | extra: ${extraOptions ?? {}} (simulated)';
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement file upload to Anthropic API if supported
    return 'Anthropic file upload: $filePath | prompt: $prompt | extra: $extraOptions (simulated)';
  }

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement image upload to Anthropic API if supported
    return 'Anthropic image upload: $imagePath | prompt: $prompt | extra: $extraOptions (simulated)';
  }

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement document upload to Anthropic API
    return 'Anthropic document upload: $documentPath | prompt: $prompt | extra: $extraOptions (simulated)';
  }
}
