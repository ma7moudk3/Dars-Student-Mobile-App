import 'package:hessa_student/app/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:hessa_student/app/routes/app_pages.dart';

import '../../app/constants/exports.dart';
import '../../generated/locales.g.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.action,
    this.readNotification = false,
    this.unReadNotificationsCount,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final Widget? action;
  final bool readNotification;
  final int? unReadNotificationsCount;
  @override
  Widget build(BuildContext context) {
    if (readNotification) {
      return GetX<BottomNavBarController>(
          builder: (BottomNavBarController controller) {
        return Container(
          width: Get.width,
          height: 95.h,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 1),
                blurRadius: 10,
              ),
            ],
          ),
          child: SafeArea(
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 20.w),
                  leading ??
                      GestureDetector(
                        onTap: () async =>
                            await Get.toNamed(Routes.NOTIFICATIONS),
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              ImagesManager.notificationIcon,
                            ),
                            Visibility(
                              visible: controller.unReadNotificationsCount.value > 0,
                              child: Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.yellow,
                                    shape: BoxShape.circle,
                                    border: const Border.fromBorderSide(
                                      BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  const Spacer(),
                  PrimaryText(
                    title ?? LocaleKeys.home,
                    fontSize: 18,
                    fontWeight: FontWeightManager.light,
                  ),
                  const Spacer(),
                  action ??
                      GestureDetector(
                        onTap: () async => await Get.toNamed(
                            Routes.HESSA_TEACHERS,
                            arguments: {
                              'searchFocus': true,
                            }),
                        child: SvgPicture.asset(
                          ImagesManager.searchIcon,
                        ),
                      ),
                  SizedBox(width: 20.w),
                ],
              ),
            ),
          ),
        );
      });
    } else {
      return Container(
        width: Get.width,
        height: 95.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 1),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20.w),
                leading ??
                    GestureDetector(
                      onTap: () async =>
                          await Get.toNamed(Routes.NOTIFICATIONS),
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            ImagesManager.notificationIcon,
                          ),
                          Visibility(
                            visible: unReadNotificationsCount != null &&
                                unReadNotificationsCount! > 0,
                            child: Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.yellow,
                                  shape: BoxShape.circle,
                                  border: const Border.fromBorderSide(
                                    BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                const Spacer(),
                PrimaryText(
                  title ?? LocaleKeys.home,
                  fontSize: 18,
                  fontWeight: FontWeightManager.light,
                ),
                const Spacer(),
                action ??
                    GestureDetector(
                      onTap: () async =>
                          await Get.toNamed(Routes.HESSA_TEACHERS, arguments: {
                        'searchFocus': true,
                      }),
                      child: SvgPicture.asset(
                        ImagesManager.searchIcon,
                      ),
                    ),
                SizedBox(width: 20.w),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
