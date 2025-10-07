import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiBatchUsecase {
  final String apiKey;
  final String model;
  GeminiBatchUsecase({required this.apiKey, required this.model});

  Future<List<String>> batchGenerate(List<String> prompts) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/$model:batchGenerate',
    );
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'prompts': prompts, 'maxOutputTokens': 256}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(
        data['candidates']?.map((c) => c['output']) ?? [],
      );
    } else {
      throw Exception('Failed to batch generate: \n${response.body}');
    }
  }
}
