enum MetaModel {
  llama2('llama-2'),
  llama3('llama-3'),
  llama3Large('llama-3-large'),
  llama3Medium('llama-3-medium'),
  llama3Small('llama-3-small'),
  codeLlama('code-llama'),
  codeLlamaPython('code-llama-python'),
  codeLlamaInstruct('code-llama-instruct');

  final String value;
  const MetaModel(this.value);
}
