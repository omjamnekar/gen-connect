import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaStreamingModelConnector {
  final String apiKey;
  MetaStreamingModelConnector({required this.apiKey});

  Future<Stream<String>> streamResponse(
    String prompt, {
    Map<String, dynamic>? extraOptions,
  }) async {
    // NOTE: Actual streaming API may differ; this is a placeholder for HTTP chunked response
    final uri = Uri.parse('https://api.meta.ai/v1/streaming/generate');
    final request = http.Request('POST', uri)
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'prompt': prompt,
        if (extraOptions != null) ...extraOptions,
      });
    final response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.transform(utf8.decoder);
    } else {
      final respStr = await response.stream.bytesToString();
      throw APIException(
        'Meta streaming error: ${response.statusCode}',
        innerException: Exception(respStr),
      );
    }
  }
}
