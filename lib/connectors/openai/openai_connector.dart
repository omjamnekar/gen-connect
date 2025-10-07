import 'package:gen_connect/connectors/openai/models/gpt3_5Turbo.dart';
import 'package:gen_connect/connectors/openai/models/gpt4.dart';
import 'package:gen_connect/connectors/openai/models/gpt4_1.dart';
import 'package:gen_connect/connectors/openai/models/gpt4o.dart';
import 'package:gen_connect/connectors/openai/models/gptImage1.dart';
import 'package:gen_connect/connectors/openai/models/gptOss120b.dart';
import 'package:gen_connect/connectors/openai/models/gptOss20b.dart';
import 'package:gen_connect/connectors/openai/models/o3.dart';
import 'package:gen_connect/connectors/openai/models/o3Mini.dart';
import 'package:gen_connect/connectors/openai/models/o3Pro.dart';
import 'package:gen_connect/connectors/openai/models/o4Mini.dart';
import 'package:gen_connect/connectors/openai/models/textEmbeddingAda002.dart';
import 'package:gen_connect/connectors/openai/usecase/file_model_connector.dart';
import 'package:gen_connect/core/constants/api.dart';
import 'package:gen_connect/enums/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/errors.dart';

import '../../repo/ai_model_connector.dart';
import 'usecase/chat_model_connector.dart';
import 'usecase/reasoning_model_connector.dart';
import 'usecase/image_model_connector.dart';
import 'usecase/audio_model_connector.dart';
import 'usecase/embedding_model_connector.dart';
import 'usecase/open_weight_model_connector.dart';

class OpenAIConnector extends AIModelConnector {
  // Usecase connector instances
  late final OpenAIChatModelConnector _chatConnector;
  late final OpenAIReasoningModelConnector _reasoningConnector;
  late final OpenAIImageModelConnector _imageConnector;
  // ignore: unused_field
  late final OpenAIAudioModelConnector _audioConnector;
  late final OpenAIEmbeddingModelConnector _embeddingConnector;
  late final OpenAIOpenWeightModelConnector _openWeightConnector;
  late final OpenAIFileModelConnector _fileConnector;
  final String apiKey;

  OpenAIConnector({required this.apiKey}) {
    _chatConnector = OpenAIChatModelConnector(apiKey: apiKey);
    _reasoningConnector = OpenAIReasoningModelConnector(apiKey: apiKey);
    _imageConnector = OpenAIImageModelConnector(apiKey: apiKey);
    _audioConnector = OpenAIAudioModelConnector(apiKey: apiKey);
    _embeddingConnector = OpenAIEmbeddingModelConnector(apiKey: apiKey);
    _fileConnector = OpenAIFileModelConnector(apiKey: apiKey);
    _openWeightConnector = OpenAIOpenWeightModelConnector(apiKey: apiKey);
  }

  @override
  Models get name => Models.OPENAI;

  // class get gpt

  Gpt35turbo get gpt3_5Turbo => Gpt35turbo(
    openAIChatModelConnector: _chatConnector,
    openAIFileModelConnector: _fileConnector,
  );

  Gpt4 get gpt4 => Gpt4(
    openAIChatModelConnector: _chatConnector,
    openAIFileModelConnector: _fileConnector,
  );

  Gpt4_1 get gpt4_1 => Gpt4_1(
    openAIChatModelConnector: _chatConnector,
    openAIFileModelConnector: _fileConnector,
  );

  Gpt4o get gpt4o => Gpt4o(
    openAIChatModelConnector: _chatConnector,
    openAIFileModelConnector: _fileConnector,
  );

  O3 get o3 => O3(openAIReasoningModelConnector: _reasoningConnector);
  O3mini get o3MIN =>
      O3mini(openAIReasoningModelConnector: _reasoningConnector);

  O3Pro get o3Pro => O3Pro(openAIReasoningModelConnector: _reasoningConnector);

  O4mini get o4mini =>
      O4mini(openAIReasoningModelConnector: _reasoningConnector);

  Gptimage1 get gptImage1 =>
      Gptimage1(openAIImageModelConnector: _imageConnector);

  Gptoss120b get gptoss120b =>
      Gptoss120b(openAIOpenWeightModelConnector: _openWeightConnector);

  Gptoss20b get gptoss20b =>
      Gptoss20b(openAIOpenWeightModelConnector: _openWeightConnector);

  Textembeddingada002 get textembeddingada002 =>
      Textembeddingada002(openAIEmbeddingModelConnector: _embeddingConnector);

  Future<String> getModelInfo(String modelName) async {
    final url = Uri.parse('https://api.openai.com/v1/models/$modelName');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI getModelInfo error: ${response.statusCode} ${response.body}',
        statusCode: response.statusCode,
      );
    }
  }

  /// List models
  Future<String> listModels() async {
    final url = Uri.parse('https://api.openai.com/v1/models');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI listModels error: ${response.statusCode} ${response.body}',
        statusCode: response.statusCode,
      );
    }
  }

  /// Get usage statistics
  Future<String> getUsage() async {
    final url = Uri.parse('https://api.openai.com/v1/dashboard/billing/usage');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw APIException(
        'OpenAI getUsage error: ${response.statusCode} ${response.body}',
        statusCode: response.statusCode,
      );
    }
  }

  Future<String> moderateContent(String input) async {
    final url = Uri.parse(ApiConstants.moderateOpenAIContent());
    final body = {'input': input};
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'OpenAI moderateContent error: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<String> translateAudio(
    String audioPath, {
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.openai.com/v1/audio/translations');
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('file', audioPath));
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
      throw APIException(
        'OpenAI audio translation error: ${response.statusCode} ${response.body}',
        statusCode: response.statusCode,
      );
    }
  }

  Future<String> sendAudiotoText(
    String audioPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    final url = Uri.parse('https://api.openai.com/v1/audio/transcriptions');
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $apiKey';
    request.files.add(await http.MultipartFile.fromPath('file', audioPath));
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
      throw APIException(
        'OpenAI audio error: ${response.statusCode} ${response.body}',
        statusCode: response.statusCode,
      );
    }
  }
}
