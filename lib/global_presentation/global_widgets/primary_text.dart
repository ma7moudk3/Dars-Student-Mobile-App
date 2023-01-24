// ignore_for_file: must_be_immutable

import 'package:hessa_student/app/constants/exports.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  TextAlign? textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final bool lineThrow;
  final double height;
  final bool hasSpecificColor;
  PrimaryText(
    this.text, {
    Key? key,
    this.fontSize = 13,
    this.color,
    this.fontWeight = FontWeightManager.light,
    this.textAlign,
    this.overflow = TextOverflow.visible,
    this.maxLines = 5,
    this.hasSpecificColor = false,
    this.lineThrow = false,
    this.height = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textAlign ??=
        Get.locale == const Locale("ar") ? TextAlign.right : TextAlign.left;

    TextStyle style = TextStyle(
      color: color,
      fontSize: (fontSize).sp,
      fontWeight: fontWeight,
      height: height,
      fontFamily: FontConstants.fontFamily,
      decoration: lineThrow ? TextDecoration.lineThrough : TextDecoration.none,
    );
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: Get.locale == const Locale("ar")
          ? TextDirection.rtl
          : TextDirection.ltr,
      style: style,
    );
  }
}
