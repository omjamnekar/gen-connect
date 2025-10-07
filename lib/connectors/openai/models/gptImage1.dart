import 'package:gen_connect/connectors/openai/usecase/image_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class Gptimage1 {
  OpenAIImageModelConnector openAIImageModelConnector;
  Gptimage1({required this.openAIImageModelConnector});

  Future<String> Function(
    String imagePath, {
    Map<String, dynamic>? extraOptions,
    String? prompt,
  })
  get sendPromptToImage => openAIImageModelConnector.sendImagetoImage;

  Future<String> Function(
    String imagePath, {
    Map<String, dynamic>? extraOptions,
    String? prompt,
  })
  get sendImagetoImageGetter => openAIImageModelConnector.sendImagetoImage;

  String get name => OpenAIModel.gptImage1.name;
}
