import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget({
    required this.iconPath,
    required this.title,
    required this.time,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String iconPath, title, time;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xfeffffff),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 45.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: ColorManager.green.withOpacity(0.20),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  color: ColorManager.green,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220.w,
                  child: PrimaryText(
                    title,
                    fontWeight: FontWeightManager.softLight,
                    fontSize: 14.sp,
                    maxLines: 2,
                    textDirection: detectLang(text: title)
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10.h),
                PrimaryText(
                  time,
                  fontWeight: FontWeightManager.softLight,
                  color: ColorManager.fontColor7,
                  textAlign: TextAlign.end,
                  fontSize: 14.sp,
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorManager.fontColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
