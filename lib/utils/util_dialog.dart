import 'package:flutter/material.dart';
import 'package:pre_interview_task/theme/app_colors.dart';
import 'package:pre_interview_task/theme/texts_style.dart';
import 'package:pre_interview_task/utils/dimensions.dart';

class StatusPopup extends StatelessWidget {
  final String title;
  final String message;
  final bool isSuccess;
  final VoidCallback? onOkPressed;

  const StatusPopup({
    super.key,
    required this.title,
    required this.message,
    this.isSuccess = true,
    this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSize),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: Dimensions.widthPopUp,
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.paddingSize),
                boxShadow: AppShadows.PopUpBoxShadow,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextsStyle.successPopUpTitleStyle,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextsStyle.successPopUpMessageStyle,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeOverE),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          onOkPressed ??
                          () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSuccess
                                ? AppColors.royalBlue
                                : AppColors.popUpAccess,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextsStyle.successPopUpOkStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 32,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient:
                        isSuccess
                            ? LinearGradient(
                              colors:
                                  isSuccess
                                      ? [
                                        AppColors.popUpBlue,
                                        AppColors.popUpLightBlue,
                                      ]
                                      : [
                                        AppColors.popUpAccess,
                                        AppColors.popUpAccess,
                                      ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                    color:
                        isSuccess ? AppColors.popUpBlue : AppColors.popUpAccess,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.paddingSize),
                      topRight: Radius.circular(Dimensions.paddingSize),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppShadows {
  const AppShadows._();
  static List<BoxShadow> commonBoxShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      blurRadius: 2,
      offset: Offset(0, 2),
    ),
  ];

  static List<BoxShadow> PopUpBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}
