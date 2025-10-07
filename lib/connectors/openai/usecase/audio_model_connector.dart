import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import '../../../repo/ai_model_connector.dart';
import '../../../core/errors.dart';

final Set<OpenAIModel> audioCapableModels = {
  // Add actual audio-capable models here when available, e.g. OpenAIModel.gptAudio1
};

class OpenAIAudioModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIAudioModelConnector({required this.apiKey, required this.model});

  String get name => Models.OPENAI.name;
}
