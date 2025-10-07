import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/repo/ai_model_connector.dart';
import 'models/palm.dart';
import 'models/palm2.dart';
import 'models/palm2_chat.dart';
import 'models/palm2_code.dart';
import 'models/palm2_vision.dart';
import 'usecase/text_model_connector.dart';
import 'usecase/code_model_connector.dart';
import 'usecase/image_model_connector.dart';
import 'usecase/audio_model_connector.dart';
import 'usecase/embedding_model_connector.dart';
import 'usecase/file_model_connector.dart';
import 'usecase/batch_model_connector.dart';
import 'usecase/streaming_model_connector.dart';
import 'usecase/tool_model_connector.dart';
import 'usecase/context_model_connector.dart';
import 'usecase/tier_model_connector.dart';
import 'usecase/attachment_model_connector.dart';
import 'usecase/token_model_connector.dart';
import 'usecase/reasoning_model_connector.dart';

class PalmConnector extends AIModelConnector {
  final String apiKey;

  // Usecase connectors
  late final PalmTextModelConnector _textConnector;
  late final PalmCodeModelConnector _codeConnector;
  late final PalmImageModelConnector _imageConnector;
  late final PalmAudioModelConnector _audioConnector;
  late final PalmEmbeddingModelConnector _embeddingConnector;
  late final PalmFileModelConnector _fileConnector;
  late final PalmBatchModelConnector _batchConnector;
  late final PalmStreamingModelConnector _streamingConnector;
  late final PalmToolModelConnector _toolConnector;
  late final PalmContextModelConnector _contextConnector;
  late final PalmTierModelConnector _tierConnector;
  late final PalmAttachmentModelConnector _attachmentConnector;
  late final PalmTokenModelConnector _tokenConnector;
  late final PalmReasoningModelConnector _reasoningConnector;

  PalmConnector({required this.apiKey}) {
    _textConnector = PalmTextModelConnector(apiKey: apiKey);
    _codeConnector = PalmCodeModelConnector(apiKey: apiKey);
    _imageConnector = PalmImageModelConnector(apiKey: apiKey);
    _audioConnector = PalmAudioModelConnector(apiKey: apiKey);
    _embeddingConnector = PalmEmbeddingModelConnector(apiKey: apiKey);
    _fileConnector = PalmFileModelConnector(apiKey: apiKey);
    _batchConnector = PalmBatchModelConnector(apiKey: apiKey);
    _streamingConnector = PalmStreamingModelConnector(apiKey: apiKey);
    _toolConnector = PalmToolModelConnector(apiKey: apiKey);
    _contextConnector = PalmContextModelConnector(apiKey: apiKey);
    _tierConnector = PalmTierModelConnector(apiKey: apiKey);
    _attachmentConnector = PalmAttachmentModelConnector(apiKey: apiKey);
    _tokenConnector = PalmTokenModelConnector(apiKey: apiKey);
    _reasoningConnector = PalmReasoningModelConnector(apiKey: apiKey);
  }

  Palm get palm => Palm(
    apiKey: apiKey,

    textConnector: _textConnector,
    codeConnector: _codeConnector,
    imageConnector: _imageConnector,
    audioConnector: _audioConnector,
    embeddingConnector: _embeddingConnector,
    fileConnector: _fileConnector,
    batchConnector: _batchConnector,
    streamingConnector: _streamingConnector,
    toolConnector: _toolConnector,
    contextConnector: _contextConnector,
    tierConnector: _tierConnector,
    attachmentConnector: _attachmentConnector,
    tokenConnector: _tokenConnector,
    reasoningConnector: _reasoningConnector,
  );

  Palm2 get palm2 => Palm2(
    apiKey: apiKey,
    textConnector: _textConnector,
    codeConnector: _codeConnector,
    imageConnector: _imageConnector,
    audioConnector: _audioConnector,
    embeddingConnector: _embeddingConnector,
    fileConnector: _fileConnector,
    batchConnector: _batchConnector,
    streamingConnector: _streamingConnector,
    toolConnector: _toolConnector,
    contextConnector: _contextConnector,
    tierConnector: _tierConnector,
    attachmentConnector: _attachmentConnector,
    tokenConnector: _tokenConnector,
    reasoningConnector: _reasoningConnector,
  );

  Palm2Chat get palm2Chat => Palm2Chat(
    apiKey: apiKey,
    textConnector: _textConnector,
    codeConnector: _codeConnector,
    imageConnector: _imageConnector,
    audioConnector: _audioConnector,
    embeddingConnector: _embeddingConnector,
    fileConnector: _fileConnector,
    batchConnector: _batchConnector,
    streamingConnector: _streamingConnector,
    toolConnector: _toolConnector,
    contextConnector: _contextConnector,
    tierConnector: _tierConnector,
    attachmentConnector: _attachmentConnector,
    tokenConnector: _tokenConnector,
    reasoningConnector: _reasoningConnector,
  );

  Palm2Code get palm2Code => Palm2Code(
    apiKey: apiKey,
    textConnector: _textConnector,
    codeConnector: _codeConnector,
    imageConnector: _imageConnector,
    audioConnector: _audioConnector,
    embeddingConnector: _embeddingConnector,
    fileConnector: _fileConnector,
    batchConnector: _batchConnector,
    streamingConnector: _streamingConnector,
    toolConnector: _toolConnector,
    contextConnector: _contextConnector,
    tierConnector: _tierConnector,
    attachmentConnector: _attachmentConnector,
    tokenConnector: _tokenConnector,
    reasoningConnector: _reasoningConnector,
  );

  Palm2Vision get palm2Vision => Palm2Vision(
    apiKey: apiKey,
    textConnector: _textConnector,
    codeConnector: _codeConnector,
    imageConnector: _imageConnector,
    audioConnector: _audioConnector,
    embeddingConnector: _embeddingConnector,
    fileConnector: _fileConnector,
    batchConnector: _batchConnector,
    streamingConnector: _streamingConnector,
    toolConnector: _toolConnector,
    contextConnector: _contextConnector,
    tierConnector: _tierConnector,
    attachmentConnector: _attachmentConnector,
    tokenConnector: _tokenConnector,
    reasoningConnector: _reasoningConnector,
  );

  @override
  Models get name => Models.PALM;
}
