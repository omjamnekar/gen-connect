import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/enums/models.dart';
import 'usecase/text_model_connector.dart';
import 'usecase/code_model_connector.dart';
import 'usecase/image_model_connector.dart';
import 'usecase/audio_model_connector.dart';
import '../../repo/ai_model_connector.dart';

class DeepSeekConnector implements AIModelConnector {
  final String apiKey;
  final DeepSeekModel model;

  late final DeepSeekTextModelConnector _textConnector;
  late final DeepSeekCodeModelConnector _codeConnector;
  late final DeepSeekImageModelConnector _imageConnector;
  late final DeepSeekAudioModelConnector _audioConnector;

  DeepSeekConnector({required this.apiKey, required this.model}) {
    _textConnector = DeepSeekTextModelConnector(apiKey: apiKey, model: model);
    _codeConnector = DeepSeekCodeModelConnector(apiKey: apiKey, model: model);
    _imageConnector = DeepSeekImageModelConnector(apiKey: apiKey, model: model);
    _audioConnector = DeepSeekAudioModelConnector(apiKey: apiKey, model: model);
  }

  @override
  String get name => Models.DEEPSEEK.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    return _textConnector.sendPrompt(
      prompt,
      temperature: temperature,
      maxTokens: maxTokens,
      systemPrompt: systemPrompt,
      extraOptions: extraOptions,
    );
  }

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    return _codeConnector.sendCode(code, extraOptions: extraOptions);
  }

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    return _imageConnector.sendImage(
      imagePath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    return _audioConnector.sendAudio(
      audioPath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('DeepSeek file upload not supported');

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async =>
      throw UnimplementedError('DeepSeek document upload not supported');
}
