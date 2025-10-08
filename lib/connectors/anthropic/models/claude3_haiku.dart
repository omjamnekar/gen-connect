import '../usecase/text.dart';
import '../usecase/code.dart';
import '../usecase/image.dart';
import '../usecase/audio.dart';
import '../usecase/embedding.dart';
import '../usecase/token.dart';
import '../usecase/file.dart';
import '../usecase/batch.dart';
import '../usecase/streaming.dart';
import '../usecase/tool.dart';
import '../usecase/context.dart';
import '../usecase/tier.dart';
import '../usecase/attachment.dart';
import '../usecase/reasoning.dart';

class Claude3Haiku {
  final String apiKey;
  final String model = 'claude-3-haiku';
  Claude3Haiku({required this.apiKey});

  AnthropicTextUsecase get text =>
      AnthropicTextUsecase(apiKey: apiKey, model: model);
  AnthropicCodeUsecase get code =>
      AnthropicCodeUsecase(apiKey: apiKey, model: model);
  AnthropicImageUsecase get image =>
      AnthropicImageUsecase(apiKey: apiKey, model: model);
  AnthropicAudioUsecase get audio =>
      AnthropicAudioUsecase(apiKey: apiKey, model: model);
  AnthropicEmbeddingUsecase get embedding =>
      AnthropicEmbeddingUsecase(apiKey: apiKey, model: model);
  AnthropicTokenUsecase get token =>
      AnthropicTokenUsecase(apiKey: apiKey, model: model);
  AnthropicFileUsecase get file =>
      AnthropicFileUsecase(apiKey: apiKey, model: model);
  AnthropicBatchUsecase get batch =>
      AnthropicBatchUsecase(apiKey: apiKey, model: model);
  AnthropicStreamingUsecase get streaming =>
      AnthropicStreamingUsecase(apiKey: apiKey, model: model);
  AnthropicToolUsecase get tool =>
      AnthropicToolUsecase(apiKey: apiKey, model: model);
  AnthropicContextUsecase get context =>
      AnthropicContextUsecase(apiKey: apiKey, model: model);
  AnthropicTierUsecase get tier =>
      AnthropicTierUsecase(apiKey: apiKey, model: model);
  AnthropicAttachmentUsecase get attachment =>
      AnthropicAttachmentUsecase(apiKey: apiKey, model: model);
  AnthropicReasoningUsecase get reasoning =>
      AnthropicReasoningUsecase(apiKey: apiKey, model: model);
}
