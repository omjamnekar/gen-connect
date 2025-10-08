import 'package:gen_connect/enums/models.dart';

/// Abstract base class for AI model connectors.
abstract class AIModelConnector {
  /// Constructor for AIModelConnector.
  AIModelConnector();

  /// Name of the AI model connector.
  Models get name;
}
