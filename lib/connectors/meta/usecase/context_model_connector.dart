import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaContextModelConnector {
  final String apiKey;
  MetaContextModelConnector({required this.apiKey});

  Future<String> getContext(
    String contextId, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/context/get');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'context_id': contextId,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['context'] ?? '';
      } else {
        throw APIException(
          'Meta context error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta context model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
