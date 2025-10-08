## 0.0.9

- Refactored all connectors to use Dio for HTTP requests, improving performance and maintainability.
- Updated Anthropic use cases to include modular connectors for reasoning, image, file, embedding, context, code, batch, audio, and attachment functionalities.
- Enhanced error handling and unified API request structure.
- Improved documentation and examples for better usability.
- Fixed performance issues in various connectors.
- Added runtime and compile-time feature restrictions for better compatibility.

## 0.0.8

- Initial release: Modular AI connector package for Dart/Flutter
- Added connectors for OpenAI, Gemini, Anthropic, Meta, Grok, DeepSeek, PaLM, and custom models
- Type-safe enums for all models/providers
- Modular connectors for text, image, audio, code, video use cases
- Unified error and exception handling via core/errors.dart
- Runtime and compile-time feature restriction per model
- Custom model support for organizations
- Example usage and documentation
