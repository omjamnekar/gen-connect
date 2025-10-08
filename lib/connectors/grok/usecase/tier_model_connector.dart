import 'package:http/http.dart' as http;
import 'package:gen_connect/enums/grok.dart';
import '../../../core/constants/api.dart';

class GrokTierModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokTierModelConnector({required this.apiKey, required this.model});

  Future<String> getTier() async {
    // Replace with the actual Grok API endpoint for tier info
    final uri = Uri.parse(ApiConstants.grokTierInfo);

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Failed to get tier: \\${response.statusCode} \\${response.body}',
      );
    }
  }
}
