import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gen_connect/connectors/openai/openai_connector.dart';
import 'package:gen_connect/connectors/gemini/gemini_connector.dart';
import 'package:gen_connect/connectors/meta/meta_connector.dart';
import 'package:gen_connect/connectors/anthropic/anthropic_connector.dart';
import 'package:gen_connect/connectors/deepseek/deepseek_connector.dart';
import 'package:gen_connect/connectors/palm/palm_connector.dart';
import 'package:gen_connect/connectors/grok/grok_connector.dart';

import 'package:gen_connect/enums/meta.dart';
import 'package:gen_connect/gen_manager.dart';

class Logger {
  final String name;
  Logger(this.name);

  void info(String message) {
    if (kDebugMode) {
      print('[$name] $message');
    }
  }
}

void main() async {
  // Instantiate connectors
  final openai = OpenAIConnector(apiKey: 'YOUR_OPENAI_KEY');
  final gemini = GeminiConnector(apiKey: 'YOUR_GEMINI_KEY');
  final meta = MetaConnector(apiKey: 'YOUR_META_KEY');
  final anthropic = AnthropicConnector(apiKey: 'YOUR_ANTHROPIC_KEY');
  final deepseek = DeepSeekConnector(apiKey: 'YOUR_DEEPSEEK_KEY');
  final palm = PalmConnector(apiKey: 'YOUR_PALM_KEY');
  final grok = GrokConnector(apiKey: 'YOUR_GROK_KEY');

  // Add connectors to GenConnectManager
  final manager = GenConnectManager.getInstance();
  manager.addConnector(openai);
  manager.addConnector(gemini);
  manager.addConnector(meta);
  manager.addConnector(anthropic);
  manager.addConnector(deepseek);
  manager.addConnector(palm);
  manager.addConnector(grok);

  runApp(AiImplementntation());
}

class AiImplementntation extends StatefulWidget {
  const AiImplementntation({super.key});

  @override
  State<AiImplementntation> createState() => _AiImplementntationState();
}

class _AiImplementntationState extends State<AiImplementntation> {
  final log = Logger('GenConnectExample');

  @override
  void initState() {
    super.initState();
    _runExamples();
  }

  Future<void> _runExamples() async {
    final manager = GenConnectManager.getInstance();

    // Retrieve and use connectors from manager
    final openaiFromManager = manager.openai;
    final geminiFromManager = manager.gemini;
    final metaFromManager = manager.meta;
    final anthropicFromManager = manager.anthropic;
    final deepseekFromManager = manager.deepseek;
    final palmFromManager = manager.palm;
    final grokFromManager = manager.grok;

    // Example usage with different models

    // OpenAI: GPT-3.5 and GPT-4
    final openaiChatGpt4 = await openaiFromManager?.gpt4.sendPrompt(
      'Hello from GPT-4!',
    );
    log.info('OpenAI chat (GPT-4): $openaiChatGpt4');
    final openaiChatGpt35 = await openaiFromManager?.gpt4_1.sendPrompt(
      'Hello from GPT-3.5!',
    );
    log.info('OpenAI chat (GPT-3.5): $openaiChatGpt35');

    // Gemini: Pro and Flash
    final geminiTextPro = await geminiFromManager?.pro.text.generateText(
      'Gemini Pro text',
    );
    log.info('Gemini text (Pro): $geminiTextPro');
    final geminiTextFlash = await geminiFromManager?.flash.text.generateText(
      'Gemini Flash text',
    );
    log.info('Gemini text (Flash): $geminiTextFlash');

    // Meta: Llama2 and Llama3
    final metaTextLlama2 = await metaFromManager?.llama2.text.sendPrompt(
      'Meta Llama2 text',
      model: MetaModel.llama2,
    );
    log.info('Meta text (Llama2): $metaTextLlama2');
    final metaTextLlama3 = await metaFromManager?.llama3.text.sendPrompt(
      'Meta Llama3 text',
      model: MetaModel.llama3,
    );
    log.info('Meta text (Llama3): $metaTextLlama3');

    // Anthropic: Claude 2 and Claude 3
    final anthropicTextClaude2 = await anthropicFromManager?.claude2.text
        .generateText('Anthropic Claude2 text');
    log.info('Anthropic text (Claude2): $anthropicTextClaude2');
    final anthropicTextClaude3 = await anthropicFromManager?.claude3.text
        .generateText('Anthropic Claude3 text');
    log.info('Anthropic text (Claude3): $anthropicTextClaude3');

    // DeepSeek: Chat and Coder
    final deepseekChat = await deepseekFromManager?.deeppseekChat.sendPrompt(
      'DeepSeek chat',
    );
    log.info('DeepSeek chat: $deepseekChat');
    final deepseekCoder = await deepseekFromManager?.deeppseekCoder.sendCode(
      'DeepSeek coder',
    );
    log.info('DeepSeek coder: $deepseekCoder');

    // PaLM: PaLM2 and Chat-Bison
    final palmText2 = await palmFromManager?.palm2.text.sendTextPrompt(
      'PaLM2 text',
    );
    log.info('PaLM text (PaLM2): $palmText2');
    final palmChatBison = await palmFromManager?.palm2Code.text.sendTextPrompt(
      'Chat-Bison text',
    );
    log.info('PaLM text (Chat-Bison): $palmChatBison');

    // Grok: 2.5 and 4
    final grokText1 = await grokFromManager?.grok2_5.text.sendPrompt(
      'Grok 1 text',
    );
    log.info('Grok text (1): $grokText1');
    final grokText2_5 = await grokFromManager?.grok4.text.sendPrompt(
      'Grok 2.5 text',
    );
    log.info('Grok text (2.5): $grokText2_5');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Text("Hello")));
  }
}
