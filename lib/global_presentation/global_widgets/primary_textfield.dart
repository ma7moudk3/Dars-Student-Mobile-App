// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/services.dart';
import 'package:hessa_student/app/constants/exports.dart';

import '../global_features/theme_manager.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Color? cursorColor;
  final String? counterText;
  final Color? ifReadOnlyTextColor;
  final BorderRadius? borderRadius;
  final BorderSide borderSide;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final FocusNode? focusNode;
  final double? fontSize;
  final BoxConstraints? suffixIconConstraints, prefixIconConstraints;
  final double titleFontSize;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool? multiLines;
  final String title;
  final Color? titleColor;
  final FontWeight titleFontWeight;
  final int? maxLength;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;

  const PrimaryTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.cursorColor,
    this.textInputAction,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.prefixIconConstraints,
    this.ifReadOnlyTextColor,
    this.textDirection,
    this.prefixIcon,
    this.maxLines,
    this.borderRadius,
    this.suffixIcon,
    this.counterText,
    this.fontSize,
    this.titleFontSize = 13,
    this.contentPadding,
    this.borderSide = const BorderSide(),
    this.onTap,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusNode,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.multiLines = false,
    required this.title,
    this.titleColor,
    this.titleFontWeight = FontWeightManager.light,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hintStyle = TextStyle(
      color: ColorManager.grey,
      fontFamily: FontConstants.fontFamily,
      fontSize: 14.sp,
    );
    var errorStyle = TextStyle(
      fontFamily: FontConstants.fontFamily,
      color: ColorManager.red,
      fontSize: 12.sp,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isNotEmpty
            ? Column(
                children: [
                  PrimaryText(
                    title,
                    fontSize: titleFontSize.sp,
                    fontWeight: titleFontWeight,
                    color: titleColor,
                  ),
                  SizedBox(height: 10.h),
                ],
              )
            : const SizedBox.shrink(),
        TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          focusNode: focusNode,
          textInputAction: textInputAction,
          maxLength: maxLength,
          maxLines: multiLines! ? (maxLines ?? 10) : 1,
          cursorColor: cursorColor ??
              (isDarkMoodEnabled()
                  ? ColorManager.darkPrimary
                  : ColorManager.fontColor),
          style: TextStyle(
            color: isDarkMoodEnabled()
                ? Colors.white
                : ifReadOnlyTextColor ?? ColorManager.fontColor,
            fontSize: fontSize,
            fontFamily: FontConstants.fontFamily,
          ),
          textDirection: textDirection,
          keyboardType: keyboardType,
          onTap: onTap ?? () {},
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted ?? (v) {},
          decoration: InputDecoration(
            disabledBorder: disabledBorder,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            errorBorder: errorBorder,
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints,
            focusColor: ColorManager.primary,
            errorMaxLines: 2,
            fillColor: isDarkMoodEnabled()
                ? ColorManager.darkAccent
                : ColorManager.white,
            filled: true,
            border: isDarkMoodEnabled()
                ? const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )
                : OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(8),
                    borderSide: borderSide),
            hoverColor: ColorManager.primary,
            errorStyle: errorStyle,
            counterText: counterText,
            hintText: hintText!.isNotEmpty ? hintText!.tr : '',
            hintStyle: hintStyle,
            contentPadding: contentPadding ??
                const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          ),
          textAlign: textDirection == TextDirection.rtl
              ? TextAlign.right
              : TextAlign.left,
          validator: validator ??
              (String? value) {
                return null;
              },
        ),
      ],
    );
  }
}
