import 'package:http/http.dart' as http;

class PalmTierModelConnector {
  final String apiKey;
  PalmTierModelConnector({required this.apiKey});

  Future<String> getTier() async {
    // Replace with the actual Palm API endpoint for tier info
    final uri = Uri.parse('https://api.palm.com/v1/tier');

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
