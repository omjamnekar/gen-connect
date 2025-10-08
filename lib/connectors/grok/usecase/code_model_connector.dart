import 'package:dio/dio.dart';
import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import '../../../core/errors.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/gen_manager.dart';

final Set<GrokModel> grokCodeModels = {
  GrokModel.grokCodeFast1,
  GrokModel.grok4Fast,
};

class GrokCodeModelConnector {
  final String apiKey;
  final GrokModel model;
  final Dio _dio;

  GrokCodeModelConnector({required this.apiKey, required this.model})
    : _dio = GenConnectManager.dio {
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
    try {
      final body = {'code': code, if (extraOptions != null) ...extraOptions};

      final response = await _dio.post(
        ApiConstants.grokCodeGenerate,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Grok code API error: ${response.statusCode} ${response.data}',
        );
      }
    } catch (e) {
      throw Exception('Error during code API call: $e');
    }
  }
}
