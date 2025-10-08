import 'package:gen_connect/core/constants/api.dart';
import 'package:http/http.dart' as http;

class PalmFileModelConnector {
  final String apiKey;
  PalmFileModelConnector({required this.apiKey});

  Future<String> uploadFile(String filePath) async {
    final uri = Uri.parse(ApiConstants.palmFile);

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $apiKey'
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
