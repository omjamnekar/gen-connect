import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/gen_manager.dart';
import '../../../core/errors.dart';
import 'package:dio/dio.dart';
import '../../../core/constants/api.dart';

const Set<OpenAIModel> chatCapableModels = {
  OpenAIModel.gpt3_5Turbo,
  OpenAIModel.gpt4,
  OpenAIModel.gpt4_1,
  OpenAIModel.gpt4o,
};

class OpenAIChatModelConnector {
  final Dio dio;
  final String apiKey;

  OpenAIChatModelConnector({required this.apiKey})
    : dio = GenConnectManager.dio;

  /// List all conversations
  Future<String> listConversations() async {
    try {
      final response = await dio.get(
        ApiConstants.listOpenAIConversations(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw APIException(
        'OpenAI listConversations error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Create a new conversation
  Future<String> createConversation(Map<String, dynamic> initialData) async {
    try {
      final response = await dio.post(
        ApiConstants.createOpenAIConversation(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: initialData,
      );
      return response.data;
    } catch (e) {
      throw APIException(
        'OpenAI createConversation error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Update a conversation
  Future<String> updateConversation(
    String conversationId,
    Map<String, dynamic> updateData,
  ) async {
    try {
      final response = await dio.patch(
        ApiConstants.updateOpenAIConversation(conversationId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: updateData,
      );
      return response.data;
    } catch (e) {
      throw APIException(
        'OpenAI updateConversation error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Delete a conversation
  Future<void> deleteConversation(String conversationId) async {
    try {
      await dio.delete(
        ApiConstants.deleteOpenAIConversation(conversationId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
    } catch (e) {
      throw APIException(
        'OpenAI deleteConversation error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Get model info
  Future<String> getModelInfo(String modelName) async {
    try {
      final response = await dio.get(
        ApiConstants.getOpenAIModelInfo(modelName),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw APIException(
        'OpenAI getModelInfo error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Moderate content
  Future<String> moderateContent(String input) async {
    try {
      final response = await dio.post(
        ApiConstants.moderateOpenAIContent(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: {'input': input},
      );
      return response.data;
    } catch (e) {
      throw APIException(
        'OpenAI moderateContent error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Retrieve a conversation by ID (if supported by OpenAI API)
  Future<String> getConversation(String conversationId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.getOpenAIConversations()}/$conversationId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw APIException(
        'OpenAI getConversation error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  String get name => Models.OPENAI.name;

  Future<String> sendPrompt(
    OpenAIModel model,
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final body = {
        'model': model.value,
        'messages': [
          if (systemPrompt != null) {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': prompt},
        ],
        if (temperature != null) 'temperature': temperature,
        if (maxTokens != null) 'max_tokens': maxTokens,
        if (extraOptions != null) ...extraOptions,
      };
      final response = await dio.post(
        ApiConstants.getOpenAIChatCompletions(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: body,
      );
      final data = response.data;
      return data['choices']?[0]?['message']?['content'] ?? '';
    } catch (e) {
      throw APIException(
        'OpenAI chat error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
