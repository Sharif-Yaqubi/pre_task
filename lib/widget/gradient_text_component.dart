// Text Gradient

import 'package:flutter/material.dart';
import 'package:pre_interview_task/theme/app_colors.dart';

class GradientTextComponent extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientTextComponent({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: const [AppColors.royalBlue, AppColors.skyBlue],
          begin: begin,
          end: end,
        ).createShader(bounds);
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}
