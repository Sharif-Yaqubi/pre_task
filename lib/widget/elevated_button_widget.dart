// create a custom Elevate button
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pre_interview_task/theme/app_colors.dart';
import 'package:pre_interview_task/theme/texts_style.dart';
import 'package:pre_interview_task/utils/dimensions.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final bool enabled;
  final bool isLoading;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = Dimensions.widthButton,
    this.enabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: Dimensions.heightButton,
      child: Container(
        decoration: BoxDecoration(
          gradient:
              enabled
                  ? const LinearGradient(
                    colors: [AppColors.royalBlue, AppColors.skyBlue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                  : const LinearGradient(
                    colors: [
                      AppColors.mediumGray,
                      Color.fromARGB(255, 216, 213, 213),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child:
              isLoading
                  ? LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: Dimensions.radiusOverLarge,
                  )
                  : Text(text, style: TextsStyle.buttonStyle),
        ),
      ),
    );
  }
}
