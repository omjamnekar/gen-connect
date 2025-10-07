import 'package:gen_connect/connectors/openai/openai_connector.dart';
import 'package:gen_connect/connectors/gemini/gemini_connector.dart';
import 'package:gen_connect/connectors/meta/meta_connector.dart';
import 'package:gen_connect/connectors/anthropic/anthropic_connector.dart';
import 'package:gen_connect/connectors/deepseek/deepseek_connector.dart';
import 'package:gen_connect/connectors/palm/palm_connector.dart';
import 'package:gen_connect/connectors/grok/grok_connector.dart';
import 'package:gen_connect/connectors/custom/custom_model_connector.dart';
import 'package:gen_connect/enums/deepseek.dart';
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/palm.dart';
import 'package:gen_connect/gen_connect.dart';

class Logger {
  final String name;
  Logger(this.name);
  void info(String message) {
    print('[$name] $message');
  }
}

void main() async {
  final log = Logger('GenConnectExample');
  final openai = OpenAIConnector(
    apiKey: 'YOUR_OPENAI_KEY',
    model: OpenAIModel.gpt4_1,
  );

  final manager = GenConnectManager.getInstance();
  manager.addConnector(openai);
  // OpenAI Example

  final openaiChat = await openai.gpt4.sendPrompt('Hello from GPT-4!');
  final openaiImage = await openai
    ..sendImage('path/to/image.png');
  final openaiAudio = await openai.sendAudio('path/to/audio.wav');
  log.info('OpenAI chat: $openaiChat');
  log.info('OpenAI image: $openaiImage');
  log.info('OpenAI audio: $openaiAudio');

  // Gemini Example
  final gemini = GeminiConnector(
    apiKey: 'YOUR_GEMINI_KEY',
    model: GeminiModel.gemini2_5Pro,
  );
  final geminiText = await gemini.sendPrompt('Gemini text');
  final geminiImage = await gemini.sendImage('path/to/image.png');
  final geminiAudio = await gemini.sendAudio('path/to/audio.wav');
  log.info('Gemini text: $geminiText');
  log.info('Gemini image: $geminiImage');
  log.info('Gemini audio: $geminiAudio');

  // Meta Example
  final meta = MetaConnector(apiKey: 'YOUR_META_KEY');
  final metaText = await meta.sendPrompt('Meta text');
  final metaImage = await meta.sendImage('path/to/image.png');
  log.info('Meta text: $metaText');
  log.info('Meta image: $metaImage');

  // Anthropic Example
  final anthropic = AnthropicConnector(apiKey: 'YOUR_ANTHROPIC_KEY');
  final anthropicText = await anthropic.sendPrompt('Anthropic text');
  log.info('Anthropic text: $anthropicText');

  // DeepSeek Example
  final deepseek = DeepSeekConnector(
    apiKey: 'YOUR_DEEPSEEK_KEY',
    model: DeepSeekModel.deepseekChat,
  );
  final deepseekChat = await deepseek.sendPrompt('DeepSeek chat');
  final deepseekCode = await deepseek.sendCode('def foo(): pass');
  final deepseekImage = await deepseek.sendImage('path/to/image.png');
  log.info('DeepSeek chat: $deepseekChat');
  log.info('DeepSeek code: $deepseekCode');
  log.info('DeepSeek image: $deepseekImage');

  // PaLM Example
  final palm = PalmConnector(
    apiKey: 'YOUR_PALM_KEY',
    model: PalmModel.palm2Vision,
  );
  final palmText = await palm.sendPrompt('PaLM text');
  final palmCode = await palm.sendCode('let x = 1;');
  final palmAudio = await palm.sendAudio('path/to/audio.wav');
  log.info('PaLM text: $palmText');
  log.info('PaLM code: $palmCode');
  log.info('PaLM audio: $palmAudio');

  // Grok Example
  final grok = GrokConnector(apiKey: 'YOUR_GROK_KEY', model: GrokModel.grok2_5);
  final grokText = await grok.sendPrompt('Grok text');
  final grokCode = await grok.sendCode('SELECT * FROM users;');
  log.info('Grok text: $grokText');
  log.info('Grok code: $grokCode');

  // Custom Model Example
  final custom = CustomModelConnector(
    endpoint: 'https://your-model-endpoint',
    apiKey: 'YOUR_CUSTOM_KEY',
    model: Models.OPENAI,
  );
  final customPrompt = await custom.sendPrompt('Custom model test');
  final customImage = await custom.sendImage('path/to/image.png');
  log.info('Custom prompt: $customPrompt');
  log.info('Custom image: $customImage');
}
