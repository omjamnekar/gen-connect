import 'dart:convert';
import 'package:http/http.dart' as http;

class AnthropicToolUsecase {
  final String apiKey;
  final String model;
  AnthropicToolUsecase({required this.apiKey, required this.model});

  Future<String> runTool(String toolName, Map<String, dynamic> params) async {
    final url = Uri.parse('https://api.anthropic.com/v1/run-tool');
    final response = await http.post(
      url,
      headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({'model': model, 'tool': toolName, 'params': params}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'] ?? '';
    } else {
      throw Exception('Failed to run tool: \n${response.body}');
    }
  }
}
