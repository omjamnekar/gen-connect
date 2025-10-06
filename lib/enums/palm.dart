enum PalmModel {
  palm('PaLM'),
  palm2('PaLM-2'),
  palm2Chat('PaLM-2-Chat'),
  palm2Code('PaLM-2-Code'),
  palm2Vision('PaLM-2-Vision');

  final String value;
  const PalmModel(this.value);
}
