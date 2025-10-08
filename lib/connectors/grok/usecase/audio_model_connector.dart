import 'package:gen_connect/enums/grok.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors.dart';
import 'package:gen_connect/core/constants/api.dart';

final Set<GrokModel> grokAudioModels = {GrokModel.grok4};

class GrokAudioModelConnector {
  final String apiKey;
  final GrokModel model;

  GrokAudioModelConnector({required this.apiKey, required this.model}) {
    if (!grokAudioModels.contains(model)) {
      throw AIConnectorError(
        'Model ${model.value} is not audio-capable. Allowed: ${grokAudioModels.map((m) => m.value).join(", ")}',
      );
    }
  }

  String get name => Models.GROK.name;

  Future<String> sendAudio(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = ApiConstants.getXaiAudioTranscriptions();
    // Make sure to add `http` to your pubspec.yaml dependencies
    // import 'package:http/http.dart' as http; at the top of your file

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('file', audioPath));

    if (prompt != null) {
      request.fields['prompt'] = prompt;
    }
    if (extraOptions != null) {
      extraOptions.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Grok audio API error: ${response.statusCode} ${response.body}',
      );
    }
  }
}
