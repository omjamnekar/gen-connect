import 'package:gen_connect/connectors/openai/usecase/embedding_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class Textembeddingada002 {
  OpenAIEmbeddingModelConnector openAIEmbeddingModelConnector;

  Textembeddingada002({required this.openAIEmbeddingModelConnector});

  Future<List<double>> Function(
    String text, {
    Map<String, dynamic>? extraOptions,
  })
  get embedText => openAIEmbeddingModelConnector.embedText;

  Future<List<List<double>>> Function(
    List<String> texts, {
    Map<String, dynamic>? extraOptions,
  })
  get embedTexts => openAIEmbeddingModelConnector.embedTexts;

  String get name => OpenAIModel.textEmbeddingAda002.name;
}
