
import '../usecases/text.dart';
import '../usecases/code.dart';
import '../usecases/image.dart';
import '../usecases/audio.dart';
import '../usecases/embedding.dart';
import '../usecases/token.dart';
import '../usecases/file.dart';
import '../usecases/batch.dart';
import '../usecases/streaming.dart';
import '../usecases/tool.dart';
import '../usecases/context.dart';
import '../usecases/tier.dart';
import '../usecases/attachment.dart';
import '../usecases/reasoning.dart';

class Claude3 {
  final String apiKey;
  final String model = 'claude-3';
  Claude3({required this.apiKey});

  AnthropicTextUsecase get text => AnthropicTextUsecase(apiKey: apiKey, model: model);
  AnthropicCodeUsecase get code => AnthropicCodeUsecase(apiKey: apiKey, model: model);
  AnthropicImageUsecase get image => AnthropicImageUsecase(apiKey: apiKey, model: model);
  AnthropicAudioUsecase get audio => AnthropicAudioUsecase(apiKey: apiKey, model: model);
  AnthropicEmbeddingUsecase get embedding => AnthropicEmbeddingUsecase(apiKey: apiKey, model: model);
  AnthropicTokenUsecase get token => AnthropicTokenUsecase(apiKey: apiKey, model: model);
  AnthropicFileUsecase get file => AnthropicFileUsecase(apiKey: apiKey, model: model);
  AnthropicBatchUsecase get batch => AnthropicBatchUsecase(apiKey: apiKey, model: model);
  AnthropicStreamingUsecase get streaming => AnthropicStreamingUsecase(apiKey: apiKey, model: model);
  AnthropicToolUsecase get tool => AnthropicToolUsecase(apiKey: apiKey, model: model);
  AnthropicContextUsecase get context => AnthropicContextUsecase(apiKey: apiKey, model: model);
  AnthropicTierUsecase get tier => AnthropicTierUsecase(apiKey: apiKey, model: model);
  AnthropicAttachmentUsecase get attachment => AnthropicAttachmentUsecase(apiKey: apiKey, model: model);
  AnthropicReasoningUsecase get reasoning => AnthropicReasoningUsecase(apiKey: apiKey, model: model);
}
