import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaTokenModelConnector {
  final String apiKey;
  MetaTokenModelConnector({required this.apiKey});

  Future<int> countTokens(
    String text, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/token/count');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': text,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['count'] ?? 0;
      } else {
        throw APIException(
          'Meta token count error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta token model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
