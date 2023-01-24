
import 'package:hessa_teacher/global_presentation/global_features/color_manager.dart';

import '../../app/constants/exports.dart';

class PrimaryTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool? multiLines;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final int noOfLines;
  final int? maxLength;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  const PrimaryTextField({
    Key? key,
    this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onTap,
    this.focusedBorder,
    this.noOfLines = 10,
    this.enabledBorder,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.multiLines = false,
    this.maxLength,
    required this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  Color color = ColorManager.white;
  Color borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
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

    // TextStyle hintStyle = GoogleFonts.tajawal(
    //     textStyle: TextStyle(
    //   color: ColorManager.greyC1,
    //   fontSize: 14.sp,
    //   fontWeight: FontWeightManager.bold,
    //   fontFamily: FontConstants.fontFamily,
    // ));

    // TextStyle style = TextStyle(
    //   color: ColorManager.fontColor,
    //   fontSize: 14.sp,
    //   fontWeight: FontWeightManager.bold,
    //   fontFamily: FontConstants.fontFamily,
    // );

    return Container(
      height: 60.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.h)),
          color: color,
          border: Border.all(color: borderColor)),
      child: Center(
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          maxLines: widget.multiLines! ? widget.noOfLines : 1,
          cursorColor: ColorManager.fontColor,
       //   style: style,
          keyboardType: widget.keyboardType,
          onTap: widget.onTap ?? () {},
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted ?? (String value) {},
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            counter: const Offstage(),
            prefixIcon: widget.prefixIcon,
            focusColor: ColorManager.primary,
            prefixIconConstraints: BoxConstraints(
              minWidth: 25.w,
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 25.w,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hoverColor: ColorManager.primary,
            hintText: widget.hintText ?? "",
            //hintStyle: hintStyle,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.grey),
            ),
          ),
          validator: widget.validator ??
              (String? value) {
                return null;
              },
        ),
      ),
    );
  }
}
