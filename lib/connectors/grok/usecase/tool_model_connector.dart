import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';

class GrokToolModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokToolModelConnector({required this.apiKey, required this.model});

  Future<String> useTool(String toolName, String input) async {
    final uri = Uri.parse(ApiConstants.grokToolRun);

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'tool': toolName, 'input': input}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to use tool: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
