import 'dart:convert';

import 'package:gen_connect/core/errors.dart';
import 'package:http/http.dart' as http;

class MetaImageModelConnector {
  final String apiKey;

  MetaImageModelConnector({required this.apiKey});

  Future<String> generateImage(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/image/generate');
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
        return data['image_url'] ?? '';
      } else {
        throw APIException(
          'Meta image generation error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta image model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
