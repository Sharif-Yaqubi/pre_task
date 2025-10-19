import 'package:flutter/material.dart';
import 'package:pre_interview_task/theme/app_colors.dart';

class TextsStyle {
  const TextsStyle._();

  /// Start Text Style

  static const newProductStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.black,
  );

  static const priceStyle = TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static const brandStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static const titleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.black,
  );

  static const appTitleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.white,
  );

  static const labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );

  static const inputStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );

  static const successPopUpTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2A2E37),
    fontFamily: 'Inter28',
  );
  static const successPopUpMessageStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Color(0xFF979797),
    fontFamily: 'Inter28',
  );
  static const successPopUpOkStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: 'Inter28',
    color: Colors.white,
  );

  static const textGradientButtonStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: 'Poppins',
  );

  static const buttonStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  static const authHintStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
}
