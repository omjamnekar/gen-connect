import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';

class GrokAttachmentModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokAttachmentModelConnector({required this.apiKey, required this.model});

  Future<String> attachFile(String filePath) async {
    // Replace with the actual Grok API endpoint for file attachment
    final uri = Uri.parse('https://api.grok.com/v1/attachments');

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
        'Failed to attach file: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
