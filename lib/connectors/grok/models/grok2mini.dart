import '../usecase/text_model_connector.dart';

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

class Grok2Mini {
  final GrokTextModelConnector textConnector;
  final GrokEmbeddingModelConnector embeddingConnector;
  final GrokFileModelConnector fileConnector;
  final GrokBatchModelConnector batchConnector;
  final GrokStreamingModelConnector streamingConnector;
  final GrokToolModelConnector toolConnector;
  final GrokContextModelConnector contextConnector;
  final GrokTierModelConnector tierConnector;
  final GrokAttachmentModelConnector attachmentConnector;
  final GrokTokenModelConnector tokenConnector;
  final GrokReasoningModelConnector reasoningConnector;

  Grok2Mini({
    required this.textConnector,
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

  GrokTextModelConnector get text => textConnector;
  GrokEmbeddingModelConnector get embedding => embeddingConnector;
  GrokFileModelConnector get file => fileConnector;
  GrokBatchModelConnector get batch => batchConnector;
  GrokStreamingModelConnector get streaming => streamingConnector;
  GrokToolModelConnector get tool => toolConnector;
  GrokContextModelConnector get context => contextConnector;
  GrokTierModelConnector get tier => tierConnector;
  GrokAttachmentModelConnector get attachment => attachmentConnector;
  GrokTokenModelConnector get token => tokenConnector;
  GrokReasoningModelConnector get reasoning => reasoningConnector;
}
