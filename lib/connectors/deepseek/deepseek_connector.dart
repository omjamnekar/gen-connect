import 'package:gen_connect/connectors/deepseek/models/deepseek_audio_model.dart';

import 'models/deepseek_chat_model.dart';
import 'models/deepseek_math_model.dart';
import 'models/deepseek_coder_model.dart';
import 'models/deepseek_vision_model.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/repo/ai_model_connector.dart';
// ...existing code...
// Removed duplicate import

class DeepSeekConnector extends AIModelConnector {
  final String apiKey;

  DeepSeekConnector({required this.apiKey});

  DeepSeekChatModel get deeppseekChat => DeepSeekChatModel(apiKey: apiKey);
  DeepSeekMathModel get deeppseekMath => DeepSeekMathModel(apiKey: apiKey);
  DeepSeekCoderModel get deeppseekCoder => DeepSeekCoderModel(apiKey: apiKey);
  DeepSeekVisionModel get deeppseekVision =>
      DeepSeekVisionModel(apiKey: apiKey);
  DeepSeekAudioModel get audio => DeepSeekAudioModel(apiKey: apiKey);

  @override
  Models get name => Models.DEEPSEEK;
}
