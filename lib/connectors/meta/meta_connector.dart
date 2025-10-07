// MetaConnector: Modular connector for Meta AI models
import 'package:gen_connect/connectors/meta/usecase/attachment_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/audio_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/batch_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/code_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/context_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/embedding_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/file_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/image_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/reasoning_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/streaming_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/text_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/tier_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/token_model_connector.dart';
import 'package:gen_connect/connectors/meta/usecase/tool_model_connector.dart';
import 'package:gen_connect/enums/models.dart';
import '../../repo/ai_model_connector.dart';
import '../../core/errors.dart';
import 'package:gen_connect/connectors/meta/models/meta_llama2.dart';
import 'package:gen_connect/connectors/meta/models/meta_llama3.dart';
import 'package:gen_connect/connectors/meta/models/meta_llama3_large.dart';
import 'package:gen_connect/connectors/meta/models/meta_llama3_medium.dart';
import 'package:gen_connect/connectors/meta/models/meta_llama3_small.dart';

class MetaConnector implements AIModelConnector {
  final String apiKey;
  final String model;

  // Usecase connectors
  late final MetaTextModelConnector textConnector;
  late final MetaCodeModelConnector codeConnector;
  late final MetaImageModelConnector imageConnector;
  late final MetaAudioModelConnector audioConnector;
  late final MetaEmbeddingModelConnector embeddingConnector;
  late final MetaFileModelConnector fileConnector;
  late final MetaBatchModelConnector batchConnector;
  late final MetaStreamingModelConnector streamingConnector;
  late final MetaToolModelConnector toolConnector;
  late final MetaContextModelConnector contextConnector;
  late final MetaTierModelConnector tierConnector;
  late final MetaAttachmentModelConnector attachmentConnector;
  late final MetaTokenModelConnector tokenConnector;
  late final MetaReasoningModelConnector reasoningConnector;

  MetaConnector({required this.apiKey, this.model = 'meta-llama-3'}) {
    textConnector = MetaTextModelConnector(apiKey: apiKey); // this
    codeConnector = MetaCodeModelConnector(apiKey: apiKey);
    imageConnector = MetaImageModelConnector(apiKey: apiKey);
    audioConnector = MetaAudioModelConnector(apiKey: apiKey);
    embeddingConnector = MetaEmbeddingModelConnector(apiKey: apiKey);
    fileConnector = MetaFileModelConnector(apiKey: apiKey);
    batchConnector = MetaBatchModelConnector(apiKey: apiKey);
    streamingConnector = MetaStreamingModelConnector(apiKey: apiKey);
    toolConnector = MetaToolModelConnector(apiKey: apiKey);
    contextConnector = MetaContextModelConnector(apiKey: apiKey);
    tierConnector = MetaTierModelConnector(apiKey: apiKey);
    attachmentConnector = MetaAttachmentModelConnector(apiKey: apiKey);
    tokenConnector = MetaTokenModelConnector(apiKey: apiKey);
    reasoningConnector = MetaReasoningModelConnector(apiKey: apiKey);
  }

  @override
  Models get name => Models.META;

  // Modular getters for all connectors
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

  MetaLlama2 get llama2 => MetaLlama2(
    apiKey: apiKey,
    textConnector: textConnector,
    codeConnector: codeConnector,
    imageConnector: imageConnector,
    audioConnector: audioConnector,
    embeddingConnector: embeddingConnector,
    fileConnector: fileConnector,
    batchConnector: batchConnector,
    streamingConnector: streamingConnector,
    toolConnector: toolConnector,
    contextConnector: contextConnector,
    tierConnector: tierConnector,
    attachmentConnector: attachmentConnector,
    tokenConnector: tokenConnector,
    reasoningConnector: reasoningConnector,
  );

  MetaLlama3 get llama3 => MetaLlama3(
    apiKey: apiKey,
    textConnector: textConnector,
    codeConnector: codeConnector,
    imageConnector: imageConnector,
    audioConnector: audioConnector,
    embeddingConnector: embeddingConnector,
    fileConnector: fileConnector,
    batchConnector: batchConnector,
    streamingConnector: streamingConnector,
    toolConnector: toolConnector,
    contextConnector: contextConnector,
    tierConnector: tierConnector,
    attachmentConnector: attachmentConnector,
    tokenConnector: tokenConnector,
    reasoningConnector: reasoningConnector,
  );

  MetaLlama3Large get llama3Large => MetaLlama3Large(
    apiKey: apiKey,
    textConnector: textConnector,
    codeConnector: codeConnector,
    imageConnector: imageConnector,
    audioConnector: audioConnector,
    embeddingConnector: embeddingConnector,
    fileConnector: fileConnector,
    batchConnector: batchConnector,
    streamingConnector: streamingConnector,
    toolConnector: toolConnector,
    contextConnector: contextConnector,
    tierConnector: tierConnector,
    attachmentConnector: attachmentConnector,
    tokenConnector: tokenConnector,
    reasoningConnector: reasoningConnector,
  );

  MetaLlama3Medium get llama3Medium => MetaLlama3Medium(
    apiKey: apiKey,
    textConnector: textConnector,
    codeConnector: codeConnector,
    imageConnector: imageConnector,
    audioConnector: audioConnector,
    embeddingConnector: embeddingConnector,
    fileConnector: fileConnector,
    batchConnector: batchConnector,
    streamingConnector: streamingConnector,
    toolConnector: toolConnector,
    contextConnector: contextConnector,
    tierConnector: tierConnector,
    attachmentConnector: attachmentConnector,
    tokenConnector: tokenConnector,
    reasoningConnector: reasoningConnector,
  );

  MetaLlama3Small get llama3Small => MetaLlama3Small(
    apiKey: apiKey,
    textConnector: textConnector,
    codeConnector: codeConnector,
    imageConnector: imageConnector,
    audioConnector: audioConnector,
    embeddingConnector: embeddingConnector,
    fileConnector: fileConnector,
    batchConnector: batchConnector,
    streamingConnector: streamingConnector,
    toolConnector: toolConnector,
    contextConnector: contextConnector,
    tierConnector: tierConnector,
    attachmentConnector: attachmentConnector,
    tokenConnector: tokenConnector,
    reasoningConnector: reasoningConnector,
  );
}
