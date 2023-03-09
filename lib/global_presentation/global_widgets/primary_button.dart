import '../../app/constants/exports.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Color? color;
  final Color? fontColor;
  final double? fontSize, width, height;
  final FontWeight fontWeight;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final bool isDisabled;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color,
    this.width,
    this.height,
    this.isDisabled = false,
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
      height: height ?? 55.h,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: isDisabled
              ? ColorManager.fontColor6.withOpacity(0.4)
              : (color ?? (ColorManager.primary)),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15.h),
            side: isDisabled
                ? BorderSide.none
                : (borderSide ??
                    BorderSide(color: ColorManager.primary, width: 1.5)),
          ),
          foregroundColor:
              isDisabled ? ColorManager.fontColor6.withOpacity(0.4) : null,
          elevation: 0,
        ),
        child: PrimaryText(
          title!,
          fontSize: fontSize!,
          color: isDisabled ? ColorManager.fontColor7 : fontColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
