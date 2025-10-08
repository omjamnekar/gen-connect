import 'package:dio/dio.dart';
import 'package:gen_connect/gen_manager.dart';
import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/constants/api.dart';

const Set<OpenAIModel> embeddingCapableModels = {
  OpenAIModel.textEmbeddingAda002,
};

class OpenAIEmbeddingModelConnector {
  final String apiKey;
  final Dio _dio;

  OpenAIEmbeddingModelConnector({required this.apiKey})
    : _dio = GenConnectManager.dio;

  String get name => Models.OPENAI.name;

  Future<List<double>> embedText(
    OpenAIModel model,
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIEmbeddings();
    final body = {
      'model': model.value,
      'input': text,
      if (extraOptions != null) ...extraOptions,
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      final data = response.data;
      final embedding = data['data']?[0]?['embedding'];
      if (embedding is List) {
        return List<double>.from(embedding.map((e) => e.toDouble()));
      } else {
        throw Exception('Embedding not found in response');
      }
    } on DioError catch (e) {
      throw Exception(
        'OpenAI Embedding API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }

  Future<List<List<double>>> embedTexts(
    OpenAIModel model,
    List<String> texts, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getOpenAIEmbeddings();
    final body = {
      'model': model.value,
      'input': texts,
      if (extraOptions != null) ...extraOptions,
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      final data = response.data;
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
    } on DioError catch (e) {
      throw Exception(
        'OpenAI Embedding API error: ${e.response?.statusCode} ${e.response?.data}',
      );
    }
  }
}
