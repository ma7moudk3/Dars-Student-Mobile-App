import '../../app/constants/exports.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Color? color;
  final Color? fontColor;
  final double? fontSize, width;
  final FontWeight fontWeight;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color,
    this.width,
    this.borderSide,
    this.borderRadius,
    this.fontSize = 13,
    this.fontWeight = FontWeightManager.light,
    this.fontColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width,
      height: 55.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: color ?? (ColorManager.primary),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15.h),
            side: borderSide ??
                BorderSide(color: ColorManager.primary, width: 1.5),
          ),
          elevation: 0,
        ),
        child: PrimaryText(
          title!,
          fontSize: fontSize!.sp,
          color: fontColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
