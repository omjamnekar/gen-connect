import 'package:gen_connect/enums/openai.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api.dart';

const Set<OpenAIModel> fileCapableModels = {
  OpenAIModel.gpt3_5Turbo,
  OpenAIModel.gpt4,
  OpenAIModel.gpt4_1,
  OpenAIModel.gpt4o,
};

class OpenAIFileModelConnector {
  final String apiKey;
  final OpenAIModel model;

  OpenAIFileModelConnector({required this.apiKey, required this.model});

  Future<String> uploadFiletoText(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse(ApiConstants.getOpenAIFiles());
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'OpenAI file upload error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<String> deleteFile(String fileId) async {
    final url = Uri.parse(ApiConstants.getOpenAIFiles() + '/$fileId');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'OpenAI file delete error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<String> getFileInfo(String fileId) async {
    final url = Uri.parse(ApiConstants.getOpenAIFiles() + '/$fileId');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'OpenAI get file info error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
