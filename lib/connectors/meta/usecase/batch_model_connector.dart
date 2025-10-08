import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaBatchModelConnector {
  final String apiKey;
  MetaBatchModelConnector({required this.apiKey});

  Future<List<dynamic>> processBatch(
    List<Map<String, dynamic>> batchRequests, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/batch/process');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'requests': batchRequests,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['results'] ?? [];
      } else {
        throw APIException(
          'Meta batch process error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta batch model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
