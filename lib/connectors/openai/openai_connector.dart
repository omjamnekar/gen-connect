import 'package:gen_connect/enums/models.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/errors.dart';

import 'usecase/ai_model_connector.dart';

class OpenAIConnector implements AIModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIConnector({required this.apiKey, this.model = OpenAIModel.gpt3_5Turbo});

  @override
  String get name => Models.OPENAI.name;

  /// Send a prompt to any chat/text/reasoning model (GPT-4, GPT-5, o-series, etc.)
  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.openai.com/v1/responses');
    final body = {
      'model': model.value,
      'input': systemPrompt != null ? '$systemPrompt\n$prompt' : prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_output_tokens': maxTokens,
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
      return data['output']?[0]?['content']?[0]?['text'] ?? '';
    } else {
      throw APIException(
        'OpenAI API error: ${response.statusCode} ${response.body}',
        statusCode: response.statusCode,
      );
    }
  }

  /// Send an image for multimodal models (e.g., GPT-4o, GPT Image 1)
  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement image upload for multimodal models
    throw AIConnectorError('OpenAI image upload not implemented');
  }

  /// Send audio for speech/voice models (e.g., GPT-4o audio)
  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement audio upload for speech models
    throw AIConnectorError('OpenAI audio upload not implemented');
  }

  /// Send a document for open-weight or custom models
  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement document upload for open-weight models
    throw AIConnectorError('OpenAI document upload not implemented');
  }

  /// Get embeddings for embedding/vector models
  Future<List<double>> getEmbedding(
    String input, {
    String embeddingModel = 'text-embedding-ada-002',
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.openai.com/v1/embeddings');
    final body = {
      'model': embeddingModel,
      'input': input,
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
      return List<double>.from(data['data']?[0]?['embedding'] ?? []);
    } else {
      throw Exception(
        'OpenAI Embedding API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// For open-weight models, allow custom endpoint
  Future<String> sendToCustomEndpoint(
    String endpoint,
    Map<String, dynamic> payload,
  ) async {
    final url = Uri.parse(endpoint);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Custom endpoint error: ${response.statusCode} ${response.body}',
      );
    }
  }

  /// Send a file for file-supported models
  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    // TODO: Implement file upload for OpenAI models if supported
    throw UnimplementedError('OpenAI file upload not implemented');
  }
}
