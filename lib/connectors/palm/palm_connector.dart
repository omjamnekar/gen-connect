import 'package:gen_connect/enums/palm.dart';
import 'model/text_model_connector.dart';
import 'model/code_model_connector.dart';
import 'model/image_model_connector.dart';
import 'model/audio_model_connector.dart';
import '../openai/usecase/ai_model_connector.dart';
import '../../core/errors.dart';

class PalmConnector implements AIModelConnector {
  final String apiKey;
  final PalmModel model;

  PalmTextModelConnector? _textConnector;
  PalmCodeModelConnector? _codeConnector;
  PalmImageModelConnector? _imageConnector;
  PalmAudioModelConnector? _audioConnector;

  PalmConnector({required this.apiKey, required this.model}) {
    if (PalmModel.palm2Vision == model) {
      _imageConnector = PalmImageModelConnector(apiKey: apiKey, model: model);
    } else if (PalmModel.palm2Code == model) {
      _codeConnector = PalmCodeModelConnector(apiKey: apiKey, model: model);
    } else if (palmTextModels.contains(model)) {
      _textConnector = PalmTextModelConnector(apiKey: apiKey, model: model);
    } else if (PalmModel.palm2 == model) {
      _audioConnector = PalmAudioModelConnector(apiKey: apiKey, model: model);
    } else {
      throw AIConnectorError(
        'Model ${model.value} is not supported for any use case.',
      );
    }
  }

  @override
  String get name => 'PaLM';

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    if (_textConnector != null) {
      return _textConnector!.sendPrompt(
        prompt,
        temperature: temperature,
        maxTokens: maxTokens,
        systemPrompt: systemPrompt,
        extraOptions: extraOptions,
      );
    }
    throw AIConnectorError(
      'Text prompt not supported for model: ${model.value}',
    );
  }

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    if (_codeConnector != null) {
      return _codeConnector!.sendCode(code, extraOptions: extraOptions);
    }
    throw UnimplementedError(
      'Code feature not supported for model: ${model.value}',
    );
  }

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    if (_imageConnector != null) {
      return _imageConnector!.sendImage(
        imagePath,
        prompt: prompt,
        extraOptions: extraOptions,
      );
    }
    throw UnimplementedError(
      'Image feature not supported for model: ${model.value}',
    );
  }

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    if (_audioConnector != null) {
      return _audioConnector!.sendAudio(
        audioPath,
        prompt: prompt,
        extraOptions: extraOptions,
      );
    }
    throw UnimplementedError(
      'Audio feature not supported for model: ${model.value}',
    );
  }

  Future<String> sendVision(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    if (model == PalmModel.palm2Vision && _imageConnector != null) {
      return _imageConnector!.sendImage(
        imagePath,
        prompt: prompt,
        extraOptions: extraOptions,
      );
    }
    throw UnimplementedError('Vision feature only available for PaLM-2-Vision');
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('PaLM file upload not supported');

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('PaLM document upload not supported');
}
