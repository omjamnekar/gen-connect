enum OpenAIModel {
  gpt3_5Turbo('gpt-3.5-turbo'),
  gpt4('gpt-4'),
  gpt4_1('gpt-4.1'),
  gpt4o('gpt-4o'),
  o3('o3'),
  o3Mini('o3-mini'),
  o3Pro('o3-pro'),
  o4Mini('o4-mini'),
  gptImage1('gpt-image-1'),
  gptOss120b('gpt-oss-120b'),
  gptOss20b('gpt-oss-20b'),
  textEmbeddingAda002('text-embedding-ada-002');

  final String value;
  const OpenAIModel(this.value);
}
