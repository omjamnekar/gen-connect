import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../openai/usecase/ai_model_connector.dart';
import '../../../core/errors.dart';

final Set<GrokModel> grokAudioModels = {GrokModel.grok4};

class GrokAudioModelConnector implements AIModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokAudioModelConnector({required this.apiKey, required this.model}) {
    if (!grokAudioModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${grokAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.GROK.name;

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Grok audio model API call
    return 'Grok audio response to: "$audioPath" | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw AIConnectorError('Text input not supported for audio models');

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('File upload not supported');

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Image input not supported');

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Document upload not supported');
}
