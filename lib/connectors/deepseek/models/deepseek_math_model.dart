import 'package:gen_connect/enums/deepseek.dart';
import '../usecase/text_model_connector.dart';

class DeepSeekMathModel {
  final DeepSeekTextModelConnector connector;

  DeepSeekMathModel({required String apiKey})
    : connector = DeepSeekTextModelConnector(
        apiKey: apiKey,
        model: DeepSeekModel.deepseekMath,
      );

  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) {
    return connector.sendPrompt(
      prompt,
      temperature: temperature,
      maxTokens: maxTokens,
      systemPrompt: systemPrompt,
      extraOptions: extraOptions,
    );
  }
}
