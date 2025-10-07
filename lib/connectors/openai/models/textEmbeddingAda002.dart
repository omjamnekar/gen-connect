import 'package:gen_connect/connectors/openai/usecase/embedding_model_connector.dart';
import 'package:gen_connect/enums/openai.dart';

class Textembeddingada002 {
  OpenAIEmbeddingModelConnector openAIEmbeddingModelConnector;

  Textembeddingada002({required this.openAIEmbeddingModelConnector});
  Future<List<double>> Function(
    String text, {
    Map<String, dynamic>? extraOptions,
  })
  get embedText => (String text, {Map<String, dynamic>? extraOptions}) {
    return openAIEmbeddingModelConnector.embedText(
      OpenAIModel.textEmbeddingAda002,
      text,
      extraOptions: extraOptions,
    );
  };

  Future<List<List<double>>> Function(
    List<String> texts, {
    Map<String, dynamic>? extraOptions,
  })
  get embedTexts => (List<String> texts, {Map<String, dynamic>? extraOptions}) {
    return openAIEmbeddingModelConnector.embedTexts(
      OpenAIModel.textEmbeddingAda002,
      texts,
      extraOptions: extraOptions,
    );
  };

  String get name => OpenAIModel.textEmbeddingAda002.name;
}
