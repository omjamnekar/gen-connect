enum GeminiModel {
  gemini2_5Pro('gemini-2.5-pro'),
  gemini2_5Flash('gemini-2.5-flash'),
  gemini2_5FlashLite('gemini-2.5-flash-lite'),
  gemini2_5FlashLitePreview('gemini-2.5-flash-lite-preview-09-2025'),
  gemini2_5FlashLive('gemini-live-2.5-flash'),
  gemini2_0Flash('gemini-2.0-flash'),
  gemini2_0FlashLite('gemini-2.0-flash-lite'),
  gemini2_0FlashLitePreview('gemini-2.0-flash-lite-preview-09-2025');

  final String value;
  const GeminiModel(this.value);
}
