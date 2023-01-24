

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
  final int? maxLength;
  final FocusNode? focusNode;

  const PasswordTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.onFieldSubmitted,
      this.title,
      this.focusNode,
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
        PrimaryText(
          widget.title ?? LocaleKeys.password.tr,
        ),
        SizedBox(
          height: 10.h,
        ),
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
          cursorColor: isDarkMoodEnabled()
              ? ColorManager.darkPrimary
              : ColorManager.fontColor,
          style: TextStyle(
              color:
                  isDarkMoodEnabled() ? Colors.white : ColorManager.fontColor),
          keyboardType: widget.keyboardType,
          obscureText: !visiblePassword,
          onFieldSubmitted: widget.onFieldSubmitted ?? (v) {},
          decoration: InputDecoration(
            focusColor: ColorManager.primary,
            errorMaxLines: 2,
            fillColor: isDarkMoodEnabled()
                ? ColorManager.darkAccent
                : ColorManager.white,
            filled: true,
            counterText: "",
            hoverColor: ColorManager.primary,
            errorStyle: TextStyle(
                        fontFamily: "NRT",
                        color: ColorManager.red,
                        fontSize: 13.sp,
                      )
                   ,
            hintStyle:  TextStyle(
                        fontFamily: "NRT",
                        color: ColorManager.grey,
                        fontSize: 14.sp,
                      )
                   ,
            border: isDarkMoodEnabled()
                ? const OutlineInputBorder(
                  borderSide: BorderSide.none,
                    borderRadius:  BorderRadius.all(Radius.circular(8.0)),
                  )
                : OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            prefixIcon: Icon(
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
