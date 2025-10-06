enum AnthropicModel {
  claudeInstant('claude-instant'),
  claude2('claude-2'),
  claude3Opus('claude-3-opus'),
  claude3Sonnet('claude-3-sonnet'),
  claude3Haiku('claude-3-haiku');

  final String value;
  const AnthropicModel(this.value);
}
