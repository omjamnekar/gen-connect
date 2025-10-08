import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaReasoningModelConnector {
  final String apiKey;
  MetaReasoningModelConnector({required this.apiKey});

  Future<String> runReasoning(
    String input, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/reasoning/run');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'input': input,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'] ?? '';
      } else {
        throw APIException(
          'Meta reasoning error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta reasoning model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
