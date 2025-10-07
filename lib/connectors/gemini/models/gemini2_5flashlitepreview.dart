import '../usecases/text.dart';
import '../usecases/code.dart';
import '../usecases/image.dart';
import '../usecases/audio.dart';
import '../usecases/embedding.dart';
import '../usecases/file.dart';
import '../usecases/batch.dart';
import '../usecases/streaming.dart';
import '../usecases/token.dart';
import '../usecases/document.dart';
import '../usecases/attachment.dart';
import '../usecases/reasoning.dart';
import '../../../enums/gemini.dart';

// ignore: camel_case_types
class Gemini2_5FlashLitePreview {
  final String apiKey;
  final GeminiModel model;
  Gemini2_5FlashLitePreview({
    required this.apiKey,
    this.model = GeminiModel.gemini2_5FlashLitePreview,
  });

  GeminiTextUsecase get text =>
      GeminiTextUsecase(apiKey: apiKey, model: model.value);
  GeminiCodeUsecase get code =>
      GeminiCodeUsecase(apiKey: apiKey, model: model.value);
  GeminiImageUsecase get image =>
      GeminiImageUsecase(apiKey: apiKey, model: model.value);
  GeminiAudioUsecase get audio =>
      GeminiAudioUsecase(apiKey: apiKey, model: model.value);
  GeminiEmbeddingUsecase get embedding =>
      GeminiEmbeddingUsecase(apiKey: apiKey, model: model.value);
  GeminiFileUsecase get file =>
      GeminiFileUsecase(apiKey: apiKey, model: model.value);
  GeminiBatchUsecase get batch =>
      GeminiBatchUsecase(apiKey: apiKey, model: model.value);
  GeminiStreamingUsecase get streaming =>
      GeminiStreamingUsecase(apiKey: apiKey, model: model.value);
  GeminiTokenUsecase get token =>
      GeminiTokenUsecase(apiKey: apiKey, model: model.value);
  GeminiDocumentUsecase get document =>
      GeminiDocumentUsecase(apiKey: apiKey, model: model.value);
  GeminiAttachmentUsecase get attachment =>
      GeminiAttachmentUsecase(apiKey: apiKey, model: model.value);
  GeminiReasoningUsecase get reasoning =>
      GeminiReasoningUsecase(apiKey: apiKey, model: model.value);
}
