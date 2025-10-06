import 'package:gen_connect/connectors/openai/openai_connector.dart';
import 'package:gen_connect/connectors/custom/custom_model_connector.dart';
import 'package:gen_connect/enums/models.dart';

void main() async {
  final openai = OpenAIConnector(apiKey: 'YOUR_OPENAI_KEY');
  final response = await openai.sendPrompt('Hello AI!');
  print('OpenAI response: $response');

  final custom = CustomModelConnector(
    endpoint: 'https://your-model-endpoint',
    apiKey: 'YOUR_CUSTOM_KEY',
    model: Models.OPENAI,
  );
  final customResponse = await custom.sendPrompt('Custom model test');
  print('Custom model response: $customResponse');
}
