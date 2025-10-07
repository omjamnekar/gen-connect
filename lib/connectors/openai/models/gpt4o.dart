import 'package:gen_connect/connectors/openai/usecase/chat_model_connector.dart';
import 'package:gen_connect/connectors/openai/usecase/file_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class Gpt4o {
  final OpenAIChatModelConnector openAIChatModelConnector;
  final OpenAIFileModelConnector openAIFileModelConnector;

  Gpt4o({
    required this.openAIChatModelConnector,
    required this.openAIFileModelConnector,
  });

  // Chat prompt
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async => openAIChatModelConnector.sendPrompt(
    OpenAIModel.gpt4o,
    prompt,
    temperature: temperature,
    maxTokens: maxTokens,
    systemPrompt: systemPrompt,
    extraOptions: extraOptions,
  );

  // File upload
  Future<String> uploadFile(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async => openAIFileModelConnector.uploadFiletoText(
    filePath,
    extraOptions: extraOptions,
  );

  // Conversation management
  Future<String> listConversations() async =>
      openAIChatModelConnector.listConversations();
  Future<String> createConversation(Map<String, dynamic> initialData) async =>
      openAIChatModelConnector.createConversation(initialData);
  Future<String> updateConversation(
    String conversationId,
    Map<String, dynamic> updateData,
  ) async =>
      openAIChatModelConnector.updateConversation(conversationId, updateData);
  Future<void> deleteConversation(String conversationId) async =>
      openAIChatModelConnector.deleteConversation(conversationId);
  Future<String> getConversation(String conversationId) async =>
      openAIChatModelConnector.getConversation(conversationId);

  // Model info
  Future<String> getModelInfo(String modelName) async =>
      openAIChatModelConnector.getModelInfo(modelName);

  // Moderation
  Future<String> moderateContent(String input) async =>
      openAIChatModelConnector.moderateContent(input);

  String get name => OpenAIModel.gpt4o.name;
}
