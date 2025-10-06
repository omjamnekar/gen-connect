import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../openai/usecase/ai_model_connector.dart';
import 'usecase/text_model_connector.dart';
import 'usecase/code_model_connector.dart';

class GrokConnector implements AIModelConnector {
  final String apiKey;
  final GrokModel model;

  late final GrokTextModelConnector _textConnector;
  late final GrokCodeModelConnector _codeConnector;

  GrokConnector({required this.apiKey, required this.model}) {
    _textConnector = GrokTextModelConnector(apiKey: apiKey, model: model);
    _codeConnector = GrokCodeModelConnector(apiKey: apiKey, model: model);
  }

  @override
  String get name => Models.GROK.name;

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
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Grok file upload not supported');

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Grok image input not supported');

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async => throw UnimplementedError('Grok document upload not supported');
}
