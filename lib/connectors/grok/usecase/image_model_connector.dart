import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<GrokModel> grokImageModels = {GrokModel.grok4, GrokModel.grok4Heavy};

class GrokImageModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokImageModelConnector({required this.apiKey, required this.model}) {
    if (!grokImageModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not image-capable. Allowed: ${grokImageModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  String get name => Models.GROK.name;

  // Only sendImage is supported for Grok image models as per xAI API docs

  Future<String> sendPromptImage(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getXaiImageGenerations();
    // import 'package:http/http.dart' as http; (add if not present)
    // The xAI API expects a POST with JSON body for image generation prompt
    final body = {
      'prompt': prompt,
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (systemPrompt != null) 'system_prompt': systemPrompt,
      if (extraOptions != null) ...extraOptions,
    };
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: body.isNotEmpty ? body.toString() : null,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Grok image API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
