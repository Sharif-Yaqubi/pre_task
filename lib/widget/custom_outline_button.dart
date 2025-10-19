import 'package:flutter/material.dart';
import 'package:pre_interview_task/utils/dimensions.dart';
import 'package:pre_interview_task/widget/gradient_text_component.dart';
import 'package:pre_interview_task/theme/app_colors.dart';
import 'package:pre_interview_task/theme/texts_style.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final FontWeight fontWeight;
  final double fontSize;
  final double width;
  final String? iconImage;
  final bool isNeedImage;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderColor = AppColors.skyBlue,
    this.textColor = AppColors.skyBlue,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Dimensions.paddingSizeExtra,
      vertical: Dimensions.paddingSizeDefault,
    ),
    this.fontWeight = FontWeight.bold,
    this.fontSize = 14,
    this.iconImage,
    required this.isNeedImage,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: isNeedImage ? Image.asset(iconImage!) : null,
        label: GradientTextComponent(
          text: text,
          style: TextsStyle.textGradientButtonStyle,
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
      ),
    );
  }
}
