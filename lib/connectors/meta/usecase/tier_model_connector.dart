import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaTierModelConnector {
  final String apiKey;
  MetaTierModelConnector({required this.apiKey});

  Future<String> getTierInfo({Map<String, dynamic>? extraOptions}) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/tier/info');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({if (extraOptions != null) ...extraOptions}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['tier'] ?? '';
      } else {
        throw APIException(
          'Meta tier info error: ${response.statusCode}',
          innerException: Exception(response.body),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta tier model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
