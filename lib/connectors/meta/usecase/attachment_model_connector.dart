import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';

class MetaAttachmentModelConnector {
  final String apiKey;
  MetaAttachmentModelConnector({required this.apiKey});

  Future<String> uploadAttachment(
    String filePath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      final uri = Uri.parse('https://api.meta.ai/v1/attachment/upload');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $apiKey'
        ..files.add(await http.MultipartFile.fromPath('file', filePath));
      if (extraOptions != null) {
        request.fields.addAll(
          extraOptions.map((k, v) => MapEntry(k, v.toString())),
        );
      }
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final data = jsonDecode(respStr);
        return data['attachment_id'] ?? '';
      } else {
        throw APIException(
          'Meta attachment upload error: ${response.statusCode}',
          innerException: Exception(respStr),
        );
      }
    } catch (e) {
      throw APIException(
        'Meta attachment model error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
