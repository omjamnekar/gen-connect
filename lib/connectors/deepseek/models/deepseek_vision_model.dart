import 'package:gen_connect/enums/deepseek.dart';
import '../usecase/image_model_connector.dart';

class DeepSeekVisionModel {
  final DeepSeekImageModelConnector connector;

  DeepSeekVisionModel({required String apiKey})
    : connector = DeepSeekImageModelConnector(
        apiKey: apiKey,
        model: DeepSeekModel.deepseekVision,
      );

  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) {
    return connector.sendImage(
      imagePath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }
}
