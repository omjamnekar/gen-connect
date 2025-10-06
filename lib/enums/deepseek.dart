enum DeepSeekModel {
  deepseekChat('deepseek-chat'),
  deepseekCoder('deepseek-coder'),
  deepseekVision('deepseek-vision'),
  deepseekMath('deepseek-math');

  final String value;
  const DeepSeekModel(this.value);
}
