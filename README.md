<p align="center">
	<img src="gen_connect.png" alt="gen_connect logo" width="400" />
</p>

gen_connect is a modular Dart/Flutter package for integrating any AI model/provider (OpenAI, Gemini, Anthropic, Meta, Grok, DeepSeek, PaLM, and custom models) into your app with type-safe, scalable connectors and unified error handling.

## Features

- Integrate multiple AI providers and models (text, image, audio, code, video)
- Type-safe enums for all models/providers
- Modular connectors for each use case
- Unified error and exception handling
- Easy extension for new models/providers
- Runtime and compile-time feature restriction
- Custom model support for organizations

## Getting started

### Prerequisites

- Dart >= 3.8.1
- Flutter >= 1.17.0
- You must add API keys for each provider you want to use (OpenAI, Gemini, Anthropic, Meta, etc.)
- Store keys securely (e.g., using environment variables or a secrets manager)

## Usage

## Connectors & Usage

This package provides modular connectors for each AI provider and use case. Each connector is type-safe and restricts features to supported models only.

### OpenAI Connector

```dart
import 'package:gen_connect/connectors/openai/openai_connector.dart';
final openai = OpenAIConnector(apiKey: 'YOUR_OPENAI_KEY');
final response = await openai.sendPrompt('Hello AI!');
```

#### Use-case connectors (OpenAI)

```dart
import 'package:gen_connect/connectors/openai/usecase/chat_model_connector.dart';
final chat = OpenAIChatModelConnector(apiKey: 'YOUR_KEY', model: OpenAIModel.gpt4);
final chatResponse = await chat.sendPrompt('Chat with GPT-4');

import 'package:gen_connect/connectors/openai/usecase/image_model_connector.dart';
final image = OpenAIImageModelConnector(apiKey: 'YOUR_KEY', model: OpenAIModel.gptImage1);
final imageResponse = await image.sendImage('path/to/image.png');
```

### Gemini Connector

```dart
import 'package:gen_connect/connectors/gemini/gemini_connector.dart';
final gemini = GeminiConnector(apiKey: 'YOUR_GEMINI_KEY');
final response = await gemini.sendPrompt('Hello Gemini!');
```

#### Use-case connectors (Gemini)

```dart
import 'package:gen_connect/connectors/gemini/usecase/text_model_connector.dart';
final text = GeminiTextModelConnector(apiKey: 'YOUR_KEY', model: GeminiModel.gemini2_5Pro);
final textResponse = await text.sendPrompt('Gemini text');
```

### Meta Connector

```dart
import 'package:gen_connect/connectors/meta/meta_connector.dart';
final meta = MetaConnector(apiKey: 'YOUR_META_KEY');
final response = await meta.sendPrompt('Hello Meta!');
```

#### Use-case connectors (Meta)

```dart
import 'package:gen_connect/connectors/meta/usecase/text_model_connector.dart';
final text = MetaTextModelConnector(apiKey: 'YOUR_KEY', model: MetaModel.llama2);
final textResponse = await text.sendPrompt('Meta text');
```

### Anthropic Connector

```dart
import 'package:gen_connect/connectors/anthropic/anthropic_connector.dart';
final anthropic = AnthropicConnector(apiKey: 'YOUR_ANTHROPIC_KEY');
final response = await anthropic.sendPrompt('Hello Claude!');
```

#### Use-case connectors (Anthropic)

```dart
import 'package:gen_connect/connectors/anthropic/usecase/text_model_connector.dart';
final text = AnthropicTextModelConnector(apiKey: 'YOUR_KEY', model: AnthropicModel.claude3Opus);
final textResponse = await text.sendPrompt('Anthropic text');
```

### DeepSeek Connector

```dart
import 'package:gen_connect/connectors/deepseek/deepseek_connector.dart';
final deepseek = DeepSeekConnector(apiKey: 'YOUR_DEEPSEEK_KEY');
final response = await deepseek.sendPrompt('Hello DeepSeek!');
```

#### Use-case connectors (DeepSeek)

```dart
import 'package:gen_connect/connectors/deepseek/usecase/text_model_connector.dart';
final text = DeepSeekTextModelConnector(apiKey: 'YOUR_KEY', model: DeepSeekModel.deepseekChat);
final textResponse = await text.sendPrompt('DeepSeek text');
```

### PaLM Connector

```dart
import 'package:gen_connect/connectors/palm/palm_connector.dart';
final palm = PalmConnector(apiKey: 'YOUR_PALM_KEY', model: PalmModel.palm2);
final response = await palm.sendPrompt('Hello PaLM!');
```

#### Use-case connectors (PaLM)

```dart
import 'package:gen_connect/connectors/palm/model/text_model_connector.dart';
final text = PalmTextModelConnector(apiKey: 'YOUR_KEY', model: PalmModel.palm2);
final textResponse = await text.sendPrompt('PaLM text');
```

### Grok Connector

```dart
import 'package:gen_connect/connectors/grok/grok_connector.dart';
final grok = GrokConnector(apiKey: 'YOUR_GROK_KEY');
final response = await grok.sendPrompt('Hello Grok!');
```

#### Use-case connectors (Grok)

```dart
import 'package:gen_connect/connectors/grok/usecase/text_model_connector.dart';
final text = GrokTextModelConnector(apiKey: 'YOUR_KEY', model: GrokModel.grok2_5);
final textResponse = await text.sendPrompt('Grok text');
```

### Custom Model Connector

```dart
import 'package:gen_connect/connectors/custom/custom_model_connector.dart';
import 'package:gen_connect/enums/models.dart';
final custom = CustomModelConnector(
  endpoint: 'https://your-model-endpoint',
  apiKey: 'YOUR_CUSTOM_KEY',
  model: Models.OPENAI,
);
final customResponse = await custom.sendPrompt('Custom model test');
```

See `/example` for more advanced usage and all available use-case connectors.

## Tips & Precautions

- **Secure your API keys:** Never hardcode keys in your source code. Use environment variables or a secrets manager.
- **Check model capabilities:** Only use features supported by each model/provider. The connectors enforce this, but always consult provider docs for limits and costs.
- **Handle errors gracefully:** All connectors use unified error handling. Catch exceptions and show user-friendly messages.
- **Monitor usage and costs:** AI APIs may incur costs. Track usage and set limits as needed.
- **Keep dependencies updated:** Regularly update this package and your dependencies for security and new features.
- **Respect provider terms:** Follow the terms of service and usage policies for each AI provider.

## Contributing & Support

- Issues and feature requests: [GitHub Issues](https://github.com/your-org/gen_connect/issues)
- Pull requests welcome!
- See CHANGELOG.md for release history.

## License

MIT
