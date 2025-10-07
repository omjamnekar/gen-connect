import '../usecase/text_model_connector.dart';
import '../usecase/code_model_connector.dart';
import '../usecase/image_model_connector.dart';
import '../usecase/audio_model_connector.dart';
import '../usecase/embedding_model_connector.dart';
import '../usecase/file_model_connector.dart';
import '../usecase/batch_model_connector.dart';
import '../usecase/streaming_model_connector.dart';
import '../usecase/tool_model_connector.dart';
import '../usecase/context_model_connector.dart';
import '../usecase/tier_model_connector.dart';
import '../usecase/attachment_model_connector.dart';
import '../usecase/token_model_connector.dart';
import '../usecase/reasoning_model_connector.dart';

class Palm2Code {
  final String apiKey;
  final PalmTextModelConnector textConnector;
  final PalmCodeModelConnector codeConnector;
  final PalmImageModelConnector imageConnector;
  final PalmAudioModelConnector audioConnector;
  final PalmEmbeddingModelConnector embeddingConnector;
  final PalmFileModelConnector fileConnector;
  final PalmBatchModelConnector batchConnector;
  final PalmStreamingModelConnector streamingConnector;
  final PalmToolModelConnector toolConnector;
  final PalmContextModelConnector contextConnector;
  final PalmTierModelConnector tierConnector;
  final PalmAttachmentModelConnector attachmentConnector;
  final PalmTokenModelConnector tokenConnector;
  final PalmReasoningModelConnector reasoningConnector;

  Palm2Code({
    required this.apiKey,
    required this.textConnector,
    required this.codeConnector,
    required this.imageConnector,
    required this.audioConnector,
    required this.embeddingConnector,
    required this.fileConnector,
    required this.batchConnector,
    required this.streamingConnector,
    required this.toolConnector,
    required this.contextConnector,
    required this.tierConnector,
    required this.attachmentConnector,
    required this.tokenConnector,
    required this.reasoningConnector,
  });

  PalmTextModelConnector get text => textConnector;
  PalmCodeModelConnector get code => codeConnector;
  PalmImageModelConnector get image => imageConnector;
  PalmAudioModelConnector get audio => audioConnector;
  PalmEmbeddingModelConnector get embedding => embeddingConnector;
  PalmFileModelConnector get file => fileConnector;
  PalmBatchModelConnector get batch => batchConnector;
  PalmStreamingModelConnector get streaming => streamingConnector;
  PalmToolModelConnector get tool => toolConnector;
  PalmContextModelConnector get context => contextConnector;
  PalmTierModelConnector get tier => tierConnector;
  PalmAttachmentModelConnector get attachment => attachmentConnector;
  PalmTokenModelConnector get token => tokenConnector;
  PalmReasoningModelConnector get reasoning => reasoningConnector;
}
