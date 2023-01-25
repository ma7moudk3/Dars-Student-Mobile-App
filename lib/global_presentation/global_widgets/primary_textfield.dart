// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final InputBorder? disabledBorder;
  final BorderRadius? borderRadius;
  final BorderSide borderSide;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool? multiLines;
  final String title;
  final int? maxLength;
  final void Function(String)? onChanged;

  const PrimaryTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.cursorColor,
    this.prefixIcon,
    this.borderRadius,
    this.suffixIcon,
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
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hintStyle = TextStyle(
      color: ColorManager.grey,
      fontSize: 14.sp,
    );
    var errorStyle = TextStyle(
      color: Colors.red,
      fontSize: 14.sp,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isNotEmpty
            ? Column(
                children: [
                  PrimaryText(
                    title,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          focusNode: focusNode,
          maxLength: maxLength,
          maxLines: multiLines! ? 10 : 1,
          cursorColor: cursorColor ??
              (isDarkMoodEnabled()
                  ? ColorManager.darkPrimary
                  : ColorManager.fontColor),
          style: TextStyle(
              color:
                  isDarkMoodEnabled() ? Colors.white : ColorManager.fontColor),
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
            suffixIcon: suffixIcon,
          
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
            errorStyle: TextStyle(
              fontFamily: FontConstants.fontFamily,
              color: ColorManager.red,
              fontSize: 12.sp,
            ),
            hintText: hintText!.isNotEmpty ? hintText!.tr : '',
            hintStyle: TextStyle(
              fontFamily: FontConstants.fontFamily,
              color: ColorManager.grey,
              fontSize: 14.sp,
            ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
          validator: validator ??
              (String? value) {
                return null;
              },
        ),
      ],
    );
  }
}
