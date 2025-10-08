import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaToolModelConnector {
  final String apiKey;
  MetaToolModelConnector({required this.apiKey});

  Future<String> runTool(
    String toolName,
    Map<String, dynamic> params, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/tool/run');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'tool': toolName,
          'params': params,
          if (extraOptions != null) ...extraOptions,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'] ?? '';
      } else {
        throw APIException(
          'Meta tool run error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta tool model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
