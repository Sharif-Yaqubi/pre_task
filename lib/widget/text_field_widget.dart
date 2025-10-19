// create a custom Text Form Field
import 'package:flutter/material.dart';
import 'package:pre_interview_task/theme/app_colors.dart';
import 'package:pre_interview_task/theme/texts_style.dart';
import 'package:pre_interview_task/utils/dimensions.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isResetPassword;
  final Color labelColor;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;
  final bool noNeedLabel;
  final bool isEnable;
  final bool isDatePicker;
  final void Function()? onTap;

  const TextFieldWidget({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    required this.hintText,
    this.isResetPassword = false,
    this.labelColor = Colors.black,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.expands = false,
    this.noNeedLabel = true,
    this.isDatePicker = false,
    this.onTap,
    this.isEnable = true,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.noNeedLabel
            ? Text(
              widget.label,
              style: TextsStyle.labelStyle.copyWith(color: widget.labelColor),
            )
            : SizedBox.shrink(),
        widget.noNeedLabel
            ? SizedBox(height: Dimensions.paddingSizeEight)
            : SizedBox.shrink(),
        TextFormField(
          controller: widget.controller,
          readOnly: widget.isDatePicker,
          onTap: widget.isDatePicker ? widget.onTap : null,
          enabled: widget.isEnable,

          keyboardType:
              widget.keyboardType ??
              (widget.maxLines != null && widget.maxLines! > 1
                  ? TextInputType.multiline
                  : TextInputType.text),
          obscureText: _obscureText,
          cursorColor: Colors.black.withValues(alpha: (0.1 * 255)),
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextsStyle.inputStyle,
          textInputAction: TextInputAction.next,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          expands: widget.expands,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,

            hintText: widget.hintText,
            hintStyle: TextsStyle.authHintStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: (0.1 * 4)),
                width: Dimensions.borderSmall,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: (0.1 * 4)),
                width: Dimensions.borderSmall,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: (0.1 * 3)),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.radiusMedium,
              vertical:
                  widget.maxLines != null && widget.maxLines! > 1
                      ? Dimensions.radiusMedium
                      : Dimensions.radiusLarge,
            ),

            suffixIcon:
                widget.isResetPassword
                    ? IconButton(
                      icon:
                          _obscureText
                              ? Image.asset('assets/images/hideEye.png')
                              : Image.asset(
                                'assets/images/eye.png',
                                width: 28,
                                height: 32,
                              ),
                      onPressed:
                          () => setState(() => _obscureText = !_obscureText),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
