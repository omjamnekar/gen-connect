import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
// ...existing code...
import 'package:gen_connect/connectors/anthropic/anthropic_connector.dart';
import 'package:gen_connect/connectors/openai/openai_connector.dart';
import 'package:gen_connect/connectors/openai/usecase/reasoning_model_connector.dart';
import 'package:gen_connect/connectors/gemini/gemini_connector.dart';
import 'package:gen_connect/enums/gemini.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/gen_connect.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  group('GenConnectManager', () {
    final openAIKey = dotenv.env['OPEN_AI_KEY'] ?? "test-key";
    final geminiAIKey = dotenv.env['GEMINI_KEY'] ?? "test-key";

    test('can add and retrieve connectors', () async {
      final manager = GenConnectManager();
      final openAI = OpenAIConnector(
        apiKey: openAIKey,
        model: OpenAIModel.gpt3_5Turbo,
      );

      final anthropic = AnthropicConnector(apiKey: 'test-key');
      manager.addConnector(openAI);
      manager.addConnector(anthropic);
      expect(
        manager.availableModels,
        containsAll([Models.OPENAI.name, Models.CLAUDE.name]),
      );
      expect(manager.getConnector(Models.OPENAI), isA<OpenAIConnector>());
      expect(manager.getConnector(Models.CLAUDE), isA<AnthropicConnector>());
    });

    test('can send prompt to OpenAI', () async {
      final manager = GenConnectManager();
      final openAI = OpenAIConnector(
        apiKey: openAIKey,
        model: OpenAIModel.gpt3_5Turbo,
      );
      manager.addConnector(openAI);
      final response = await manager.sendPrompt(Models.OPENAI.name, 'Hello!');
      expect(response, contains('OpenAI response'));
    });

    test('can send prompt to Anthropic', () async {
      final manager = GenConnectManager();
      final anthropic = AnthropicConnector(apiKey: 'test-key');
      manager.addConnector(anthropic);
      final response = await manager.sendPrompt(Models.CLAUDE.name, 'Hello!');
      expect(response, contains('Anthropic response'));
    });

    test('can send prompt to Gemini', () async {
      final manager = GenConnectManager();
      final gemini = GeminiConnector(
        apiKey: geminiAIKey,
        model: GeminiModel.gemini2_0Flash,
      );
      manager.addConnector(gemini);
      try {
        final response = await manager.sendPrompt('Gemini', 'Hello Gemini!');
        // Gemini API will fail with test-key, so we expect an exception
        expect(response, isNotNull);
      } catch (e) {
        expect(e.toString(), contains('Gemini API error'));
      }
    });

    test('Gemini file upload throws', () async {
      final gemini = GeminiConnector(
        apiKey: geminiAIKey,
        model: GeminiModel.gemini2_0Flash,
      );
      expect(() => gemini.sendFile('file.txt'), throwsUnimplementedError);
    });

    test('Gemini image upload throws', () async {
      final gemini = GeminiConnector(
        apiKey: geminiAIKey,
        model: GeminiModel.gemini2_0FlashLite,
      );
      expect(() => gemini.sendImage('image.png'), throwsUnimplementedError);
    });

    test('Gemini document upload throws', () async {
      final gemini = GeminiConnector(
        apiKey: geminiAIKey,
        model: GeminiModel.gemini2_0FlashLite,
      );
      expect(() => gemini.sendDocument('doc.pdf'), throwsUnimplementedError);
    });

    test('can send prompt to OpenAI Reasoning Model', () async {
      final connector = OpenAIReasoningModelConnector(
        apiKey: openAIKey,
        model: OpenAIModel.gpt4,
      );
      try {
        final response = await connector.sendPrompt('Test reasoning prompt');
        // With a fake key, expect an exception
        expect(response, isNotNull);
      } catch (e) {
        expect(e.toString(), contains('OpenAI Reasoning API error'));
      }
    });
  });
}
