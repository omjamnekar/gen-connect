import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokFileModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokFileModelConnector({required this.apiKey, required this.model});

  Future<String> uploadFile(String filePath) async {
    // Replace with the actual Grok API endpoint for file upload
    final uri = Uri.parse('https://api.grok.com/v1/files');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..fields['model'] = model.name
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to upload file: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
