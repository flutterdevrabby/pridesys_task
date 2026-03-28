import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/text_font_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final String? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final int maxLines;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool filled;
  final String obscuringCharacter;
  final ColorFilter? prefixIconColorFilter;

  // Border Customization
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextAlign? align;

  const CustomTextField({
    super.key,
    this.controller,
    this.prefix,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
    this.focusNode,
    this.contentPadding,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.textInputAction,
    this.inputFormatters,
    this.onTap,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.style,
    this.hintStyle,
    this.fillColor,
    this.filled = false,
    this.obscuringCharacter = '*',
    this.prefixIconColorFilter,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: align ?? TextAlign.start,
      cursorColor: Colors.white,
      style:
          style ??
          TextFontStyle.headLine18CFFFFFFW700.copyWith(fontSize: 18.sp),
      obscuringCharacter: obscuringCharacter,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: inputFormatters,
      onTap: onTap,
      decoration: InputDecoration(
        prefix: prefix,
        hintStyle:
            hintStyle ??
            TextFontStyle.headLine18CFFFFFFW700.copyWith(
              color: Color(0x667F8C8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
        fillColor: fillColor ?? Color(0xFFEFEFF1),
        filled: filled,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(
                  prefixIcon!,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: prefixIconColorFilter,
                  fit: BoxFit.contain,
                ),
              )
            : null,
        suffixIcon: suffixIcon,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.1.w),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.sp),
              borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.1.w),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.sp), //c044192
              borderSide: BorderSide(color: Colors.blue, width: 0.1.w),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.sp),
              borderSide: BorderSide(color: Color(0xFFFF0000), width: 0.1.w),
            ),
      ),
    );
  }
}
