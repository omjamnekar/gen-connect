import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaCodeModelConnector {
  final String apiKey;
  MetaCodeModelConnector({required this.apiKey});

  Future<String> generateCode(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/code/generate');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': prompt,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['code'] ?? '';
      } else {
        throw APIException(
          'Meta code generation error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta code model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
