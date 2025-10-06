enum GrokModel {
  grok2Mini('grok-2-mini'),
  grok2_5('grok-2.5'),
  grok3('grok-3'),
  grok3Mini('grok-3-mini'),
  grok4('grok-4'),
  grok4Heavy('grok-4-heavy'),
  grokCodeFast1('grok-code-fast-1'),
  grok4Fast('grok-4-fast');

  final String value;
  const GrokModel(this.value);
}
