import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:http/http.dart' as http;

final Set<GrokModel> grokTextModels = {
  GrokModel.grok2Mini,
  GrokModel.grok2_5,
  GrokModel.grok3,
  GrokModel.grok3Mini,
  GrokModel.grok4,
  GrokModel.grok4Heavy,
};

class GrokTextModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokTextModelConnector({required this.apiKey, required this.model}) {
    if (!grokTextModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not text-capable. Allowed: ${grokTextModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  String get name => Models.GROK.name;

  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.grokTextGenerate;
    final body = {
      'model': model.value,
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
      throw APIException(
        'Grok text model error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
