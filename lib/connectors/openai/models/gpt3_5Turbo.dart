import 'package:gen_connect/connectors/openai/usecase/chat_model_connector.dart';
import 'package:gen_connect/connectors/openai/usecase/file_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class Gpt35turbo {
  OpenAIChatModelConnector openAIChatModelConnector;
  OpenAIFileModelConnector openAIFileModelConnector;
  Gpt35turbo({
    required this.openAIChatModelConnector,
    required this.openAIFileModelConnector,
  });

  Future<String> get listConversations =>
      openAIChatModelConnector.listConversations();

  Future<String> Function(Map<String, dynamic>) get createConversation =>
      openAIChatModelConnector.createConversation;

  Future<String> Function(String, Map<String, dynamic>)
  get updateConversation => openAIChatModelConnector.updateConversation;

  Future<void> Function(String) get deleteConversation =>
      openAIChatModelConnector.deleteConversation;

  Future<String> Function(String) get getModelInfo =>
      openAIChatModelConnector.getModelInfo;

  Future<String> get listModels => openAIChatModelConnector.listModels();

  Future<String> Function(String) get moderateContent =>
      openAIChatModelConnector.moderateContent;

  Future<String> Function(String) get getConversation =>
      openAIChatModelConnector.getConversation;

  Future<String> Function(
    String, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  })
  get sendPrompt => openAIChatModelConnector.sendPrompt;

  Future<String> Function(String, {Map<String, dynamic>? extraOptions})
  get uploadFile => openAIFileModelConnector.uploadFiletoText;

  Future<void> Function(String) get deleteFile =>
      openAIFileModelConnector.deleteFile;

  Future<String> Function(String) get getFileInfo =>
      openAIFileModelConnector.getFileInfo;

  String get name => OpenAIModel.gpt3_5Turbo.name;
}
