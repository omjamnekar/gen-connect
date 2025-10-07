enum DeepSeekModel {
  deepseekChat('deepseek-chat'),
  deepseekCoder('deepseek-coder'),
  deepseekVision('deepseek-vision'),
  deepseekMath('deepseek-math'),
  deepseekAudio('deepseek-audio');

  final String value;
  const DeepSeekModel(this.value);
}
