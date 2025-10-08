import 'dart:convert';
import 'package:gen_connect/core/constants/api.dart';
import 'package:http/http.dart' as http;

class PalmTokenModelConnector {
  final String apiKey;
  PalmTokenModelConnector({required this.apiKey});

  Future<int> countTokens(String text) async {
    final uri = Uri.parse(ApiConstants.palmTokenize);

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'text': text}),
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
