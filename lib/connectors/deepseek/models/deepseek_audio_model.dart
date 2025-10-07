import 'package:gen_connect/enums/deepseek.dart';
import '../usecase/audio_model_connector.dart';

class DeepSeekAudioModel {
  final DeepSeekAudioModelConnector connector;

  DeepSeekAudioModel({required String apiKey})
    : connector = DeepSeekAudioModelConnector(
        apiKey: apiKey,
        model: DeepSeekModel.deepseekAudio,
      );

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) {
    return connector.sendAudio(
      audioPath,
      prompt: prompt,
      extraOptions: extraOptions,
    );
  }
}
