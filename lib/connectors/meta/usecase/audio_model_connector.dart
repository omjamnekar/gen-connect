import 'package:gen_connect/repo/ai_model_connector.dart';
import 'package:gen_connect/enums/meta.dart';
import 'package:gen_connect/enums/models.dart';

final Set<MetaModel> metaAudioModels = {MetaModel.llama3Large};

class MetaAudioModelConnector implements AIModelConnector {
  final String apiKey;
  final MetaModel model;

  MetaAudioModelConnector({required this.apiKey, required this.model}) {
    if (!metaAudioModels.contains(model)) {
      throw ArgumentError(
        'Model ${model.value} is not audio-capable. Allowed: ${metaAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  @override
  String get name => Models.META.name;

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement Meta audio model API call
    return 'Meta audio response to: "$audioPath" | model: ${model.value}';
  }

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Text input not supported');

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
