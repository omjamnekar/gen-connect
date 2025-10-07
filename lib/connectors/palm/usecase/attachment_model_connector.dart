import 'package:http/http.dart' as http;

class PalmAttachmentModelConnector {
  final String apiKey;
  PalmAttachmentModelConnector({required this.apiKey});

  Future<String> attachFile(String filePath) async {
    // Replace with the actual Palm API endpoint for file attachment
    final uri = Uri.parse('https://api.palm.com/v1/attachments');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to attach file: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
