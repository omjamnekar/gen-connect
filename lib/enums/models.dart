enum Models {
  GEMINI('Gemini'),
  GPT_3('GPT-3'),
  GPT_4('GPT-4'),
  LLAMA_2('LLaMA-2'),
  CLAUDE('Claude'),
  CLAUDE_V1('Claude-v1'),
  CLAUDE_V2('Claude-v2'),
  CLAUDE_V3('Claude-v3'),

  PALM('PaLM'),
  OPENAI('OpenAI'),
  META('Meta'),
  DEEPSEEK('DeepSeek'),
  GROK('Grok');

  final String name;
  const Models(this.name);
}
