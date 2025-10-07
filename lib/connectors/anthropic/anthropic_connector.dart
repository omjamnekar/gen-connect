import 'package:gen_connect/enums/models.dart';
import '../../repo/ai_model_connector.dart';
import 'models/claude2.dart';
import 'models/claude3.dart';
import 'models/claude_instant.dart';
import 'models/claude3_opus.dart';
import 'models/claude3_sonnet.dart';
import 'models/claude3_haiku.dart';

class AnthropicConnector implements AIModelConnector {
  final String apiKey;
  final String model;

  AnthropicConnector({required this.apiKey, this.model = 'claude-2'});

  Claude2 get claude2 => Claude2(apiKey: apiKey);
  Claude3 get claude3 => Claude3(apiKey: apiKey);
  ClaudeInstant get claudeInstant => ClaudeInstant(apiKey: apiKey);
  Claude3Opus get claude3Opus => Claude3Opus(apiKey: apiKey);
  Claude3Sonnet get claude3Sonnet => Claude3Sonnet(apiKey: apiKey);
  Claude3Haiku get claude3Haiku => Claude3Haiku(apiKey: apiKey);

  @override
  Models get name => Models.CLAUDE;
}
