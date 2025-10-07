import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';

final Set<OpenAIModel> audioCapableModels = {
  // Add actual audio-capable models here when available, e.g. OpenAIModel.gptAudio1
};

class OpenAIAudioModelConnector {
  final String apiKey;

  OpenAIAudioModelConnector({required this.apiKey});

  String get name => Models.OPENAI.name;
}
