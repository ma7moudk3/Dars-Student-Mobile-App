import '../../../constants/exports.dart';

class MoreItem extends StatelessWidget {
  const MoreItem(
      {Key? key,
      required this.iconPath,
      required this.title,
      this.subTitle,
      this.settingsColor,
      this.textSettingsColor,
      this.actionIconSettingsColor,
      required this.onTap,
      required this.color,
      required this.iconColor,
      this.transform = false,
      this.isAlone = false,
      this.border,
      this.boxShadow,
      this.action,
      this.width = 17,
      this.height = 17})
      : super(key: key);

  final String iconPath;
  final String title;
  final String? subTitle;
  final GestureTapCallback? onTap;
  final BoxBorder? border;
  final Color color, iconColor;
  final List<BoxShadow>? boxShadow;
  final bool isAlone;
  final Widget? action;
  final double width, height;
  final bool transform;
  final Color? settingsColor, textSettingsColor, actionIconSettingsColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: border,
          color: settingsColor ?? ColorManager.white,
          boxShadow: boxShadow,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: (isAlone) ? 15.h : 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: (transform)
                          ? Transform.scale(
                              scaleX: Get.locale!.languageCode != "ar" ? 1 : -1,
                              child: SvgPicture.asset(
                                width: width.w,
                                height: height.h,
                                iconPath,
                                color: iconColor,
                              ),
                            )
                          : SvgPicture.asset(
                              width: width.w,
                              height: height.h,
                              iconPath,
                              color: iconColor,
                            ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        title,
                        hasSpecificColor: textSettingsColor != null,
                        color: textSettingsColor,
                        fontWeight: FontWeightManager.softLight,
                        textAlign: TextAlign.end,
                        fontSize: 14,
                      ),
                      Visibility(
                        visible: subTitle != null,
                        child: Column(
                          children: [
                            SizedBox(height: 5.h),
                            PrimaryText(
                              subTitle ?? "",
                              hasSpecificColor: textSettingsColor != null,
                              color: ColorManager.fontColor7,
                              fontWeight: FontWeightManager.softLight,
                              textAlign: TextAlign.end,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              action ??
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: actionIconSettingsColor ?? ColorManager.fontColor,
                    size: 16,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
