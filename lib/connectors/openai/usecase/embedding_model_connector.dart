import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../repo/ai_model_connector.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api.dart';

const Set<OpenAIModel> embeddingCapableModels = {
  OpenAIModel.textEmbeddingAda002,
};

class OpenAIEmbeddingModelConnector {
  final String apiKey;

  OpenAIEmbeddingModelConnector({required this.apiKey});

  String get name => Models.OPENAI.name;

  Future<List<double>> embedText(
    OpenAIModel model,
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIEmbeddings());
    final body = {
      'model': model.value,
      'input': text,
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
      final embedding = data['data']?[0]?['embedding'];
      if (embedding is List) {
        return List<double>.from(embedding.map((e) => e.toDouble()));
      } else {
        throw Exception('Embedding not found in response');
      }
    } else {
      throw Exception(
        'OpenAI Embedding API error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<List<List<double>>> embedTexts(
    OpenAIModel model,
    List<String> texts, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIEmbeddings());
    final body = {
      'model': model.value,
      'input': texts,
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
      final embeddings = data['data'];
      if (embeddings is List) {
        return embeddings
            .map(
              (e) =>
                  List<double>.from(e['embedding'].map((ee) => ee.toDouble())),
            )
            .toList();
      } else {
        throw Exception('Embeddings not found in response');
      }
    } else {
      throw Exception(
        'OpenAI Embedding API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
