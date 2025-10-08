import 'package:gen_connect/enums/gemini.dart';

class ApiConstants {
  // List all conversations
  static String listOpenAIConversations() => "$openaiBaseUrl/conversations";
  // Create a new conversation
  static String createOpenAIConversation() => "$openaiBaseUrl/conversations";
  // Update a conversation
  static String updateOpenAIConversation(String id) =>
      "$openaiBaseUrl/conversations/$id";
  // Delete a conversation
  static String deleteOpenAIConversation(String id) =>
      "$openaiBaseUrl/conversations/$id";
  // Get model info
  static String getOpenAIModelInfo(String model) =>
      "$openaiBaseUrl/models/$model";
  // List models
  static String listOpenAIModels() => "$openaiBaseUrl/models";
  // Moderate content
  static String moderateOpenAIContent() => "$openaiBaseUrl/moderations";
  // Get usage
  static String getOpenAIUsage() => "$openaiBaseUrl/dashboard/billing/usage";
  // OpenAI Conversations API (for managing chat threads)
  static String getOpenAIConversations() => "$openaiBaseUrl/conversations";
  // OPENAI API ENDPOINTS
  static final openaiBaseUrl = "https://api.openai.com/v1";

  static String getOpenAIChatCompletions() => "$openaiBaseUrl/chat/completions";
  static String getOpenAIImageGenerations() =>
      "$openaiBaseUrl/images/generations";
  static String getOpenAIAudioTranscriptions() =>
      "$openaiBaseUrl/audio/transcriptions";
  static String getOpenAIAudioTranslations() =>
      "$openaiBaseUrl/audio/translations";
  static String getOpenAIEmbeddings() => "$openaiBaseUrl/embeddings";
  static String getOpenAIFiles() => "$openaiBaseUrl/files";
  static String getOpenAIFineTunes() => "$openaiBaseUrl/fine-tunes";
  static String getOpenAIModels() => "$openaiBaseUrl/models";
  static String getOpenAIModerations() => "$openaiBaseUrl/moderations";

  static final geminibaseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models";

  static String getGeminicall(GeminiModel model, String apiKey) =>
      "$geminibaseUrl/${model.value}:generateContent?key=$apiKey";

  static String getGeminiFileCall(GeminiModel model, String apiKey) =>
      "$geminibaseUrl/${model.value}:analyzeFile?key=$apiKey";

  static String getGeminiImageCall(GeminiModel model, String apiKey) =>
      "$geminibaseUrl/${model.value}:analyzeImage?key=$apiKey";

  static String getGeminiDocumentCall(GeminiModel model, String apiKey) =>
      "$geminibaseUrl/${model.value}:analyzeDocument?key=$apiKey";

  static String getGeminiVideoCall(GeminiModel model, String apiKey) =>
      "$geminibaseUrl/${model.value}:analyzeVideo?key=$apiKey";

  static String getGeminiAudioCall(GeminiModel model, String apiKey) =>
      "$geminibaseUrl/${model.value}:analyzeAudio?key=$apiKey";

  // xAI (Grok) API ENDPOINTS
  static final xaiBaseUrl = "https://api.x.ai/v1";
  static String getXaiChatCompletions() => "$xaiBaseUrl/chat/completions";
  static String getXaiImageGenerations() => "$xaiBaseUrl/images/generations";
  static String getXaiAudioTranscriptions() =>
      "$xaiBaseUrl/audio/transcriptions";
  static String getXaiAudioTranslations() => "$xaiBaseUrl/audio/translations";
  static String getXaiEmbeddings() => "$xaiBaseUrl/embeddings";
  static String getXaiFiles() => "$xaiBaseUrl/files";
  static String getXaiFineTunes() => "$xaiBaseUrl/fine-tunes";
  static String getXaiModels() => "$xaiBaseUrl/models";
  static String getXaiModerations() => "$xaiBaseUrl/moderations";
  static String getXaiCodeCompletions() => "$xaiBaseUrl/code/completions";

  // Palm API ENDPOINTS
  static const String palmAttachments = 'https://api.palm.com/v1/attachments';
  static const String palmTool = 'https://api.palm.com/v1/tool';
  static const String palmTokenize = 'https://api.palm.com/v1/tokenize';
  static const String palmTier = 'https://api.palm.com/v1/tier';
  static const String palmText = 'https://api.palm.com/v1/text';
  static const String palmEmbedding = 'https://api.palm.com/v1/embedding';
  static const String palmStreaming = 'https://api.palm.com/v1/stream';
  static const String palmReasoning = 'https://api.palm.com/v1/reasoning';
  static const String palmImage = 'https://api.palm.com/v1/image';
  static const String palmFile = 'https://api.palm.com/v1/file';
  static const String palmAudio = 'https://api.palm.com/v1/audio';
  static const String palmBatch = 'https://api.palm.com/v1/batch';
  static const String palmCode = 'https://api.palm.com/v1/code';
  static const String palmContext = 'https://api.palm.com/v1/context';

  // Meta API ENDPOINTS
  static const String metaTextGenerate = 'https://api.meta.ai/v1/text/generate';
  static const String metaImageGenerate =
      'https://api.meta.ai/v1/image/generate';
  static const String metaAttachmentUpload =
      'https://api.meta.ai/v1/attachment/upload';
  static const String metaToolRun = 'https://api.meta.ai/v1/tool/run';
  static const String metaAudioTranscribe =
      'https://api.meta.ai/v1/audio/transcribe';
  static const String metaTokenCount = 'https://api.meta.ai/v1/token/count';
  static const String metaTierInfo = 'https://api.meta.ai/v1/tier/info';
  static const String metaBatchProcess = 'https://api.meta.ai/v1/batch/process';
  static const String metaContextRetrieve =
      'https://api.meta.ai/v1/context/retrieve';
  static const String metaStreamingData =
      'https://api.meta.ai/v1/streaming/data';
  static const String metaReasoningAnalyze =
      'https://api.meta.ai/v1/reasoning/analyze';
  static const String metaFileUpload = 'https://api.meta.ai/v1/file/upload';
  static const String metaEmbeddingGenerate =
      'https://api.meta.ai/v1/embedding/generate';
  static const String metaCodeGenerate = 'https://api.meta.ai/v1/code/generate';

  // Grok API ENDPOINTS
  static const String grokFileUpload = 'https://api.grok.com/v1/files';
  static const String grokEmbeddingGenerate =
      'https://api.grok.com/v1/embedding';
  static const String grokCodeGenerate = 'https://api.grok.com/v1/code';
  static const String grokAttachmentUpload =
      'https://api.grok.com/v1/attachments';
  static const String grokAudioTranscriptions = 'https://api.grok.com/v1/audio';
  static const String grokBatchProcess = 'https://api.grok.com/v1/batch';
  static const String grokContextSet = 'https://api.grok.com/v1/context';
  static const String grokImageGenerate = 'https://api.grok.com/v1/image';
  static const String grokReasoningAnalyze =
      'https://api.grok.com/v1/reasoning';
  static const String grokStreamingData = 'https://api.grok.com/v1/stream';
  static const String grokTextGenerate = 'https://api.grok.com/v1/text';
  static const String grokTierInfo = 'https://api.grok.com/v1/tier';
  static const String grokTokenCount = 'https://api.grok.com/v1/tokenize';
  static const String grokToolRun = 'https://api.grok.com/v1/tool';

  // Gemini API ENDPOINTS
  static String geminiUploadAttachment(String model) =>
      "$geminibaseUrl/models/$model:uploadAttachment";
  static String geminiTranscribeAudio(String model) =>
      "$geminibaseUrl/models/$model:transcribeAudio";
  static String geminiBatchGenerate(String model) =>
      "$geminibaseUrl/models/$model:batchGenerate";
  static String geminiGenerateCode(String model) =>
      "$geminibaseUrl/models/$model:generateCode";
  static String geminiUploadDocument(String model) =>
      "$geminibaseUrl/models/$model:uploadDocument";
  static String geminiEmbedText(String model) =>
      "$geminibaseUrl/models/$model:embedText";
  static String geminiUploadFile(String model) =>
      "$geminibaseUrl/models/$model:uploadFile";
  static String geminiGenerateImage(String model) =>
      "$geminibaseUrl/models/$model:generateImage";
  static String geminiGetReasoning(String model) =>
      "$geminibaseUrl/models/$model:getReasoning";
  static String geminiStreamGenerate(String model) =>
      "$geminibaseUrl/models/$model:streamGenerate";
  static String geminiGenerateText(String model) =>
      "$geminibaseUrl/models/$model:generateText";
  static String geminiCountTokens(String model) =>
      "$geminibaseUrl/models/$model:countTokens";

  // DeepSeek API ENDPOINTS
  static const String deepSeekAudio = 'https://api.deepseek.com/v1/audio';
  static const String deepSeekCode = 'https://api.deepseek.com/v1/code';
  static const String deepSeekImage = 'https://api.deepseek.com/v1/image';
  static const String deepSeekText = 'https://api.deepseek.com/v1/text';

  // Claude API ENDPOINTS
  static const String claudeMessages = 'https://api.anthropic.com/v1/messages';
  static const String claudeBatch = 'https://api.anthropic.com/v1/batch';
  static const String claudeTokenCount =
      'https://api.anthropic.com/v1/messages/count-tokens';

  // Anthropic API ENDPOINTS
  static const String anthropicUploadAttachment =
      'https://api.anthropic.com/v1/upload-attachment';
  static const String anthropicTranscribeAudio =
      'https://api.anthropic.com/v1/transcribe-audio';
  static const String anthropicBatchComplete =
      'https://api.anthropic.com/v1/batch-complete';
  static const String anthropicComplete =
      'https://api.anthropic.com/v1/complete';
  static const String anthropicContext = 'https://api.anthropic.com/v1/context';
  static const String anthropicEmbeddings =
      'https://api.anthropic.com/v1/embeddings';
  static const String anthropicUploadFile =
      'https://api.anthropic.com/v1/upload-file';
  static const String anthropicGenerateImage =
      'https://api.anthropic.com/v1/generate-image';
  static const String anthropicReasoning =
      'https://api.anthropic.com/v1/reasoning';
  static const String anthropicStreamComplete =
      'https://api.anthropic.com/v1/stream-complete';
  static const String anthropicTier = 'https://api.anthropic.com/v1/tier';
  static const String anthropicTokenize =
      'https://api.anthropic.com/v1/tokenize';
  static const String anthropicRunTool =
      'https://api.anthropic.com/v1/run-tool';
}
