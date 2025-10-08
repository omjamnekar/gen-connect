import 'package:gen_connect/core/constants/api.dart';
import 'package:http/http.dart' as http;

class PalmTierModelConnector {
  final String apiKey;
  PalmTierModelConnector({required this.apiKey});

  Future<String> getTier() async {
    final uri = Uri.parse(ApiConstants.palmTier);

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
