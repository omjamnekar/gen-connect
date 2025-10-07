import 'package:gen_connect/repo/ai_model_connector.dart';
import 'package:gen_connect/enums/palm.dart';
import '../../../core/errors.dart';

final Set<PalmModel> palmAudioModels = {PalmModel.palm2};

class PalmAudioModelConnector implements AIModelConnector {
  final String apiKey;
  final PalmModel model;

  PalmAudioModelConnector({required this.apiKey, required this.model}) {
    if (!palmAudioModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${palmAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => 'PaLM';

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement PaLM audio model API call
    return 'PaLM audio response to: "$audioPath" | model: ${model.value}';
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
