import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';

import '../openai/usecase/ai_model_connector.dart';
import 'usecase/text_model_connector.dart';
import 'usecase/image_model_connector.dart';
import 'usecase/audio_model_connector.dart';
import 'usecase/video_model_connector.dart';

class GeminiConnector implements AIModelConnector {
  final String apiKey;
  final GeminiModel model;

  late final GeminiTextModelConnector _textConnector;
  late final GeminiImageModelConnector _imageConnector;
  late final GeminiAudioModelConnector _audioConnector;
  late final GeminiVideoModelConnector _videoConnector;

  GeminiConnector({required this.apiKey, required this.model}) {
    _textConnector = GeminiTextModelConnector(apiKey: apiKey, model: model);
    _imageConnector = GeminiImageModelConnector(apiKey: apiKey, model: model);
    _audioConnector = GeminiAudioModelConnector(apiKey: apiKey, model: model);
    _videoConnector = GeminiVideoModelConnector(apiKey: apiKey, model: model);
  }

  @override
  String get name => Models.GEMINI.name;

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

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Gemini file upload not supported');

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

  Future<String> sendVideo(
    String videoPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    return _videoConnector.sendVideo(
      videoPath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Gemini document upload not supported');
}
