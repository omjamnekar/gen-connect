import 'package:gen_connect/connectors/openai/usecase/ai_model_connector.dart';
import 'package:gen_connect/enums/models.dart';
import '../../core/errors.dart';

// ...existing code...

/// Connector for user-defined custom models (e.g., organization-specific models).
/// Connector for user-defined custom models (e.g., organization-specific models).
class CustomModelConnector implements AIModelConnector {
  @override
  final String name;
  final String endpoint;
  final String apiKey;
  final Models model;
  final Map<String, dynamic>? extraConfig;

  CustomModelConnector({
    required this.endpoint,
    required this.apiKey,
    required this.model,
    this.extraConfig,
  }) : name = model.name;

  @override
  Future<String> sendPrompt(
    String prompt, {
    double? temperature,
    int? maxTokens,
    String? systemPrompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      // Example: Make a POST request to the custom model endpoint
      // You can use http or dio package for real implementation
      // This is a stub for demonstration
      return 'Custom model response for: $prompt';
    } catch (e) {
      throw APIException(
        'Custom model prompt error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<String> sendFile(
    String filePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      return 'Custom model file response for: $filePath';
    } catch (e) {
      throw APIException(
        'Custom model file error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<String> sendImage(
    String imagePath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      return 'Custom model image response for: $imagePath';
    } catch (e) {
      throw APIException(
        'Custom model image error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<String> sendDocument(
    String documentPath, {
    String? prompt,
    Map<String, dynamic>? extraOptions,
  }) async {
    try {
      return 'Custom model document response for: $documentPath';
    } catch (e) {
      throw APIException(
        'Custom model document error',
        innerException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
  // TODO: implement name
  // String get name => throw UnimplementedError();
  
  // Removed duplicate methods
