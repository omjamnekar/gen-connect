import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';

/// Base Gemini connector (not to be used directly)
abstract class GeminiBaseConnector implements AIModelConnector {
  final String apiKey;
  final GeminiModel model;
  GeminiBaseConnector({required this.apiKey, required this.model});
  @override
  String get name => Models.GEMINI.name;
}
