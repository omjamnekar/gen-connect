import 'dart:convert';

import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<GrokModel> grokCodeModels = {
  GrokModel.grokCodeFast1,
  GrokModel.grok4Fast,
};

class GrokCodeModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokCodeModelConnector({required this.apiKey, required this.model}) {
    if (!grokCodeModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not code-capable. Allowed: ${grokCodeModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  String get name => Models.GROK.name;

  Future<String> sendCode(
    String code, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getXaiCodeCompletions();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'code': code, ...?extraOptions}),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Grok code API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
