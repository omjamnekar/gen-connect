import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../repo/ai_model_connector.dart';
import '../../../core/errors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api.dart';

const Set<OpenAIModel> chatCapableModels = {
  OpenAIModel.gpt3_5Turbo,
  OpenAIModel.gpt4,
  OpenAIModel.gpt4_1,
  OpenAIModel.gpt4o,
};

class OpenAIChatModelConnector {
  /// List all conversations

  final String apiKey;

  OpenAIChatModelConnector({required this.apiKey});
  Future<String> listConversations() async {
    final url = Uri.parse(ApiConstants.listOpenAIConversations());
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI listConversations error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Create a new conversation
  Future<String> createConversation(Map<String, dynamic> initialData) async {
    final url = Uri.parse(ApiConstants.createOpenAIConversation());
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(initialData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI createConversation error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Update a conversation
  Future<String> updateConversation(
    String conversationId,
    Map<String, dynamic> updateData,
  ) async {
    final url = Uri.parse(
      ApiConstants.updateOpenAIConversation(conversationId),
    );
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(updateData),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI updateConversation error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Delete a conversation
  Future<void> deleteConversation(String conversationId) async {
    final url = Uri.parse(
      ApiConstants.deleteOpenAIConversation(conversationId),
    );
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw APIException(
        'OpenAI deleteConversation error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Get model info
  Future<String> getModelInfo(String modelName) async {
    final url = Uri.parse(ApiConstants.getOpenAIModelInfo(modelName));
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI getModelInfo error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Moderate content
  Future<String> moderateContent(String input) async {
    final url = Uri.parse(ApiConstants.moderateOpenAIContent());
    final body = {'input': input};
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI moderateContent error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Retrieve a conversation by ID (if supported by OpenAI API)
  Future<String> getConversation(String conversationId) async {
    final url = Uri.parse(
      '${ApiConstants.getOpenAIConversations()}/$conversationId',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI getConversation error: ${response.statusCode} ${response.body}',
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
      final url = Uri.parse(ApiConstants.getOpenAIChatCompletions());
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
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices']?[0]?['message']?['content'] ?? '';
      } else {
        throw APIException(
          'OpenAI chat error: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw APIException(
        'OpenAI chat error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
