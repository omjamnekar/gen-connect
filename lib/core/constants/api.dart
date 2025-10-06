import 'package:gen_connect/enums/gemini.dart';

class ApiConstants {
  final geminibaseUrl =
      " https://generativelanguage.googleapis.com/v1beta/models";
  static String getGeminicall(GeminiModel model, String apiKey) =>
      "/${model.value}:generateContent?key=$apiKey";
}
