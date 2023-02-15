import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';

import '../global_features/theme_manager.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final Color? cursorColor;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final BorderRadius? borderRadius;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final BorderSide borderSide;
  final bool isRequired;
  final int? maxLength;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final double? titleSpacing;

  const PasswordTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.onFieldSubmitted,
      this.title,
      this.titleSpacing,
      this.borderRadius,
      this.isRequired = false,
      this.prefixIcon,
      this.titleFontSize,
      this.titleFontWeight,
      this.cursorColor,
      this.borderSide = const BorderSide(),
      this.focusNode,
      this.disabledBorder,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.keyboardType = TextInputType.visiblePassword,
      this.maxLength})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool visiblePassword = false;

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
        widget.isRequired
            ? Row(
                children: [
                  PrimaryText(
                    widget.title ?? LocaleKeys.password.tr,
                    fontWeight:
                        widget.titleFontWeight ?? FontWeightManager.light,
                    fontSize: widget.titleFontSize ?? 13,
                  ),
                  SizedBox(width: 2.w),
                  PrimaryText(
                    "*",
                    fontSize: 16.sp,
                    fontWeight: FontWeightManager.softLight,
                    color: ColorManager.accent,
                  ),
                ],
              )
            : PrimaryText(
                widget.title ?? LocaleKeys.password.tr,
                fontWeight: widget.titleFontWeight ?? FontWeightManager.light,
                fontSize: widget.titleFontSize ?? 13,
              ),
        SizedBox(height: (widget.titleSpacing ?? 10).h),
        /*
                    decoration: BoxDecoration(
              borderRadius: appType == AppType.customer
                  ? const BorderRadius.all(Radius.circular(50))
                  : const BorderRadius.all(Radius.circular(8.0)),
              color: isDarkMoodEnabled()
                  ? ColorManager.darkAccent
                  : ColorManager.white,

        */
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          cursorColor: widget.cursorColor ??
              (isDarkMoodEnabled()
                  ? ColorManager.darkPrimary
                  : ColorManager.fontColor),
          style: TextStyle(
              color:
                  isDarkMoodEnabled() ? Colors.white : ColorManager.fontColor),
          keyboardType: widget.keyboardType,
          obscureText: !visiblePassword,
          onFieldSubmitted: widget.onFieldSubmitted ?? (v) {},
          decoration: InputDecoration(
            disabledBorder: widget.disabledBorder,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            errorBorder: widget.errorBorder,
            focusColor: ColorManager.primary,
            errorMaxLines: 2,
            fillColor: isDarkMoodEnabled()
                ? ColorManager.darkAccent
                : ColorManager.white,
            filled: true,
            counterText: "",
            hoverColor: ColorManager.primary,
            errorStyle: TextStyle(
              fontFamily: FontConstants.fontFamily,
              color: ColorManager.red,
              fontSize: 13.sp,
            ),
            hintStyle: TextStyle(
              fontFamily: FontConstants.fontFamily,
              color: ColorManager.grey,
              fontSize: 14.sp,
            ),
            border: isDarkMoodEnabled()
                ? OutlineInputBorder(
                    borderSide: widget.borderSide,
                    borderRadius: widget.borderRadius ??
                        const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                  )
                : OutlineInputBorder(
                    borderSide: widget.borderSide,
                    borderRadius: widget.borderRadius ??
                        const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                  ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            prefixIcon: widget.prefixIcon ??
                Icon(
                  Icons.lock_outline,
                  color: ColorManager.grey,
                  size: 23.w,
                ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visiblePassword = !visiblePassword;
                });
              },
              icon: visiblePassword
                  ? Icon(
                      Icons.visibility_off,
                      color: ColorManager.grey,
                    )
                  : Icon(
                      Icons.visibility,
                      color: ColorManager.grey,
                    ),
            ),
            hintText: widget.hintText!.isNotEmpty ? widget.hintText!.tr : '',
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
