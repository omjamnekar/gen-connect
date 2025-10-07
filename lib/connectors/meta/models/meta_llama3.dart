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

class MetaLlama3 {
  final String apiKey;
  final MetaTextModelConnector textConnector;
  final MetaCodeModelConnector codeConnector;
  final MetaImageModelConnector imageConnector;
  final MetaAudioModelConnector audioConnector;
  final MetaEmbeddingModelConnector embeddingConnector;
  final MetaFileModelConnector fileConnector;
  final MetaBatchModelConnector batchConnector;
  final MetaStreamingModelConnector streamingConnector;
  final MetaToolModelConnector toolConnector;
  final MetaContextModelConnector contextConnector;
  final MetaTierModelConnector tierConnector;
  final MetaAttachmentModelConnector attachmentConnector;
  final MetaTokenModelConnector tokenConnector;
  final MetaReasoningModelConnector reasoningConnector;

  MetaLlama3({
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

  MetaTextModelConnector get text => textConnector;
  MetaCodeModelConnector get code => codeConnector;
  MetaImageModelConnector get image => imageConnector;
  MetaAudioModelConnector get audio => audioConnector;
  MetaEmbeddingModelConnector get embedding => embeddingConnector;
  MetaFileModelConnector get file => fileConnector;
  MetaBatchModelConnector get batch => batchConnector;
  MetaStreamingModelConnector get streaming => streamingConnector;
  MetaToolModelConnector get tool => toolConnector;
  MetaContextModelConnector get context => contextConnector;
  MetaTierModelConnector get tier => tierConnector;
  MetaAttachmentModelConnector get attachment => attachmentConnector;
  MetaTokenModelConnector get token => tokenConnector;
  MetaReasoningModelConnector get reasoning => reasoningConnector;
}
