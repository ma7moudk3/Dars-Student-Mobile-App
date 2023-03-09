import 'package:hessa_student/global_presentation/global_features/theme_manager.dart';

import '../../app/constants/exports.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    Key? key,
    this.onTap,
    this.selected,
    this.isSkip = false,
    this.icon,
    required this.title,
    this.color,
    this.borderColor,
    this.fontColor,
    this.width,
    this.fontSize = 15,
    this.borderRadius,
    this.height,
    this.fontWeight = FontWeightManager.medium,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final double? width, height, fontSize;
  final Icon? icon;
  final String title;
  final BorderRadiusGeometry? borderRadius;
  final bool? selected, isSkip;
  final Color? color, borderColor, fontColor;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 80.w,
        height: height ?? 35.h,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
              width: 1,
              color: (selected != null)
                  ? ((selected! == false)
                      ? isDarkMoodEnabled()
                          ? ColorManager.white.withOpacity(0.8)
                          : ColorManager.grey
                      : borderColor ?? ColorManager.primary)
                  : borderColor ?? ColorManager.primary),
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              title,
              color: (selected != null)
                  ? ((selected! == false)
                      ? isDarkMoodEnabled()
                          ? ColorManager.grey
                          : ColorManager.grey5
                      : borderColor ?? ColorManager.accent)
                  : isDarkMoodEnabled()
                      ? ColorManager.white
                      : fontColor ?? ColorManager.primary,
              fontSize: fontSize ?? 15,
              fontWeight: fontWeight,
            ),
            Visibility(
              visible: (selected != null && selected!),
              child: Row(
                children: [
                  SizedBox(width: 15.w),
                  icon ?? const SizedBox(),
                ],
              ),
            ),
            Visibility(
              visible: (isSkip!),
              child: Row(
                children: [
                  SizedBox(width: 5.w),
                  icon ?? const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
