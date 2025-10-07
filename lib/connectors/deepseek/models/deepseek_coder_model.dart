import 'package:gen_connect/enums/deepseek.dart';
import '../usecase/code_model_connector.dart';

class DeepSeekCoderModel {
  final DeepSeekCodeModelConnector connector;

  DeepSeekCoderModel({required String apiKey})
    : connector = DeepSeekCodeModelConnector(
        apiKey: apiKey,
        model: DeepSeekModel.deepseekCoder,
      );

  Future<String> sendCode(String code, {Map<String, dynamic>? extraOptions}) {
    return connector.sendCode(code, extraOptions: extraOptions);
  }
}
