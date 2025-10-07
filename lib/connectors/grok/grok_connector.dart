import 'package:gen_connect/connectors/grok/usecase/text_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/code_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/image_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/audio_model_connector.dart';
import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../repo/ai_model_connector.dart';
import 'models/grok2mini.dart';
import 'models/grok2_5.dart';
import 'models/grok3.dart';
import 'models/grok3mini.dart';
import 'models/grok4.dart';
import 'models/grok4heavy.dart';
import 'models/grokcodefast1.dart';
import 'models/grok4fast.dart';
import 'package:gen_connect/connectors/grok/usecase/embedding_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/file_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/batch_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/streaming_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/tool_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/context_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/tier_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/attachment_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/token_model_connector.dart';
import 'package:gen_connect/connectors/grok/usecase/reasoning_model_connector.dart';

class GrokConnector extends AIModelConnector {
  final String apiKey;

  GrokConnector({required this.apiKey});

  Grok2Mini get grok2Mini => Grok2Mini(
    textConnector: GrokTextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2Mini,
    ),
  );
  Grok2_5 get grok2_5 => Grok2_5(
    textConnector: GrokTextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok2_5,
    ),
  );
  Grok3 get grok3 => Grok3(
    textConnector: GrokTextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3,
    ),
  );
  Grok3Mini get grok3Mini => Grok3Mini(
    textConnector: GrokTextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok3Mini,
    ),
  );
  Grok4 get grok4 => Grok4(
    textConnector: GrokTextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    imageConnector: GrokImageModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    audioConnector: GrokAudioModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4,
    ),
  );
  Grok4Heavy get grok4Heavy => Grok4Heavy(
    textConnector: GrokTextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    imageConnector: GrokImageModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Heavy,
    ),
  );
  GrokCodeFast1 get grokCodeFast1 => GrokCodeFast1(
    codeConnector: GrokCodeModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grokCodeFast1,
    ),
  );
  Grok4Fast get grok4Fast => Grok4Fast(
    codeConnector: GrokCodeModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    embeddingConnector: GrokEmbeddingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    fileConnector: GrokFileModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    batchConnector: GrokBatchModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    streamingConnector: GrokStreamingModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    toolConnector: GrokToolModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    contextConnector: GrokContextModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    tierConnector: GrokTierModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    attachmentConnector: GrokAttachmentModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    tokenConnector: GrokTokenModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
    reasoningConnector: GrokReasoningModelConnector(
      apiKey: apiKey,
      model: GrokModel.grok4Fast,
    ),
  );

  @override
  Models get name => Models.GROK;
}

// ...existing code...
