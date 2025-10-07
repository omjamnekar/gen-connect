import 'dart:convert';
import 'package:gen_connect/enums/meta.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaTextModelConnector {
  final String apiKey;

  MetaTextModelConnector({required this.apiKey});

  String get name => Models.META.name;

  Future<String> sendPrompt(
    String prompt, {
    required MetaModel model,
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // Example HTTPS call using Dart's http package
      final uri = Uri.parse('https://api.meta.ai/v1/text/generate');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': model.value,
          'prompt': prompt,
          if (temperature != null) 'temperature': temperature,
          if (maxTokens != null) 'max_tokens': maxTokens,
          if (systemPrompt != null) 'system_prompt': systemPrompt,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'] ?? '';
      } else {
        throw APIException(
          'Meta text model error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta text model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
