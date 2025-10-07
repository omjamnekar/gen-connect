import 'models/gemini2_5pro.dart';
import 'models/gemini2_5flash.dart';
import 'models/gemini2_5flashlite.dart';
import 'models/gemini2_5flashlitepreview.dart';
import 'models/gemini2_5flashlive.dart';
import 'models/gemini2_0flash.dart';
import 'models/gemini2_0flashlite.dart';
import 'models/gemini2_0flashlitepreview.dart';
import '../../enums/gemini.dart';
import '../../enums/models.dart';
import '../../repo/ai_model_connector.dart';

class GeminiConnector extends AIModelConnector {
  final String apiKey;

  GeminiConnector({required this.apiKey});

  GeminiPro get pro => GeminiPro(apiKey: apiKey);
  Gemini2_5Flash get flash => Gemini2_5Flash(apiKey: apiKey);
  Gemini2_5FlashLite get flashLite => Gemini2_5FlashLite(apiKey: apiKey);
  Gemini2_5FlashLitePreview get flashLitePreview =>
      Gemini2_5FlashLitePreview(apiKey: apiKey);
  Gemini2_5FlashLive get flashLive => Gemini2_5FlashLive(apiKey: apiKey);
  Gemini2_0Flash get flash2_0 => Gemini2_0Flash(apiKey: apiKey);
  Gemini2_0FlashLite get flash2_0Lite => Gemini2_0FlashLite(apiKey: apiKey);
  Gemini2_0FlashLitePreview get flash2_0LitePreview =>
      Gemini2_0FlashLitePreview(apiKey: apiKey);

  @override
  Models get name => Models.GEMINI;
}
