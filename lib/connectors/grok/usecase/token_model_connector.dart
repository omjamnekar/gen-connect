import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';

class GrokTokenModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokTokenModelConnector({required this.apiKey, required this.model});

  Future<int> countTokens(String text) async {
    final uri = Uri.parse(ApiConstants.grokTokenCount);

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'model': model.name, 'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token_count'] as int;
    } else {
      throw Exception(
        'Failed to count tokens: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
