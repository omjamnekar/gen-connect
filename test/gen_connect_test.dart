import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gen_connect/connectors/anthropic/anthropic_connector.dart';
import 'package:gen_connect/connectors/openai/openai_connector.dart';
import 'package:gen_connect/connectors/openai/usecase/reasoning_model_connector.dart';
import 'package:gen_connect/connectors/gemini/gemini_connector.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/gen_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  final openAIKey = dotenv.env['OPEN_AI_KEY'] ?? "test-key";
  final geminiAIKey = dotenv.env['GEMINI_KEY'] ?? "test-key";

  group('GenConnectManager', () {
    test('should add and retrieve connectors', () {
      final manager = GenConnectManager.getInstance();
      final openAI = OpenAIConnector(apiKey: openAIKey);
      final anthropic = AnthropicConnector(apiKey: 'test-key');
      manager.addConnector(openAI);
      manager.addConnector(anthropic);
      expect(
        manager.availableModels,
        containsAll([Models.OPENAI.name, Models.CLAUDE.name]),
      );
      expect(manager.openai, isA<OpenAIConnector>());
      expect(manager.anthropic, isA<AnthropicConnector>());
    });

    test('should send prompt to OpenAI', () async {
      final manager = GenConnectManager.getInstance();
      final openAI = OpenAIConnector(apiKey: openAIKey);
      manager.addConnector(openAI);
      final response = await manager.openai?.gpt3_5Turbo.sendPrompt('Hello!');
      expect(response, isA<String>());
    });

    test('should send prompt to Anthropic', () async {
      final manager = GenConnectManager.getInstance();
      final anthropic = AnthropicConnector(apiKey: 'test-key');
      manager.addConnector(anthropic);
      final response = await manager.anthropic?.claude2.text.generateText(
        'Hello!',
      );
      expect(response, isA<String>());
    });

    test('should send prompt to Gemini', () async {
      final manager = GenConnectManager.getInstance();
      final gemini = GeminiConnector(apiKey: geminiAIKey);
      manager.addConnector(gemini);
      try {
        final response = await manager.gemini?.flash2_0.text.generateText(
          'Hello Gemini!',
        );
        expect(response, isA<String>());
      } catch (e) {
        expect(e.toString(), contains('Failed to generate text'));
      }
    });

    test('Gemini file upload', () async {
      final gemini = GeminiConnector(apiKey: geminiAIKey);
      final fileUsecase = gemini.flash2_0.file;
      try {
        final response = await fileUsecase.uploadFile(
          'base64string',
          'file.txt',
        );
        expect(response, isA<String>());
      } catch (e) {
        expect(e.toString(), contains('Failed to upload file'));
      }
    });

    test('Gemini image upload', () async {
      final gemini = GeminiConnector(apiKey: geminiAIKey);
      final imageUsecase = gemini.flash2_0Lite.image;
      try {
        final response = await imageUsecase.generateImage('image prompt');
        expect(response, isA<String>());
      } catch (e) {
        expect(e.toString(), contains('Failed to generate image'));
      }
    });

    test('Gemini document upload', () async {
      final gemini = GeminiConnector(apiKey: geminiAIKey);
      final docUsecase = gemini.flash2_0Lite.document;
      try {
        final response = await docUsecase.uploadDocument(
          'base64string',
          'doc.pdf',
        );
        expect(response, isA<String>());
      } catch (e) {
        expect(e.toString(), contains('Failed to upload document'));
      }
    });

    test('should send prompt to OpenAI Reasoning Model', () async {
      final connector = OpenAIReasoningModelConnector(apiKey: openAIKey);
      try {
        final response = await connector.sendPromptReasoning(
          'Test reasoning prompt',
          OpenAIModel.gpt4,
        );
        expect(response, isA<String>());
      } catch (e) {
        expect(e.toString(), contains('OpenAI Reasoning API error'));
      }
    });
  });
}
