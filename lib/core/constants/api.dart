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
}
