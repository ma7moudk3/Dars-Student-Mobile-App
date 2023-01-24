import '../../app/constants/exports.dart';


import '../global_features/theme_manager.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final FocusNode focusNode;
  final double leftOrRightPadding;
  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.enabledBorder,
    this.focusedBorder,
    this.validator,
    this.leftOrRightPadding = 0.0,
    this.onFieldSubmitted,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool visiblePassword = false;
  Color color = ColorManager.white;
  Color borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // TextStyle hintStyle = GoogleFonts.tajawal(
    //     textStyle: TextStyle(
    //   color: ColorManager.greyC1,
    //   fontSize: 14.sp,
    //   fontWeight: FontWeightManager.bold,
    //   fontFamily: FontConstants.fontFamily,
    // ));

    // TextStyle style = TextStyle(
    //   fontSize: 14.sp,
    //   fontWeight: FontWeightManager.bold,
    //   fontFamily: FontConstants.fontFamily,
    // );
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        color = Colors.white;
        borderColor = ColorManager.primary;
      } else {
        color = ColorManager.white;
        borderColor = Colors.transparent;
      }
      setState(() {});
    });

    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: color,
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          cursorColor: ColorManager.primary,
         // style: style,
          textDirection: Get.locale!.languageCode == "ar"
              ? TextDirection.rtl
              : TextDirection.ltr,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !visiblePassword,
          onFieldSubmitted: widget.onFieldSubmitted ?? (v) {},
          decoration: InputDecoration(
            focusColor: ColorManager.primary,
            hoverColor: ColorManager.primary,
          //  hintStyle: hintStyle,
            hintTextDirection: Get.locale!.languageCode == "ar"
                ? TextDirection.rtl
                : TextDirection.ltr,
            focusedBorder: widget.focusedBorder,
            enabledBorder: widget.enabledBorder,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: (widget.focusNode != null)
                  ? widget.focusNode.hasFocus
                      ? (isDarkMoodEnabled()
                          ? ColorManager.accent
                          : ColorManager.grey)
                      : ColorManager.grey
                  : ColorManager.grey,
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
                      Icons.visibility_off_outlined,
                      color: (widget.focusNode != null)
                          ? widget.focusNode.hasFocus
                              ? (isDarkMoodEnabled()
                                  ? ColorManager.accent
                                  : ColorManager.grey)
                              : ColorManager.grey
                          : ColorManager.grey,
                    )
                  : Icon(
                      Icons.visibility_outlined,
                      color: (widget.focusNode != null)
                          ? widget.focusNode.hasFocus
                              ? (isDarkMoodEnabled()
                                  ? ColorManager.accent
                                  : ColorManager.grey)
                              : ColorManager.grey
                          : ColorManager.grey,
                    ),
            ),
            hintText: widget.hintText!.isNotEmpty ? widget.hintText!.tr : '',
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
