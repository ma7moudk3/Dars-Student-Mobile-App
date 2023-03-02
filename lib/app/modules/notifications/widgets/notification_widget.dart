import 'package:animator/animator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../controllers/notifications_controller.dart';
import '../data/models/notification_data/item.dart';
import 'delete_notification_dialog_content.dart';

class NotificationWidget extends GetView<NotificationsController> {
  NotificationWidget({
    required this.iconPath,
    required this.onTap,
    required this.index,
    required this.itemNotification,
    Key? key,
  }) : super(key: key);

  final String iconPath;
  void Function()? onTap;
  final Item itemNotification;
  final int index;
  @override
  Widget build(BuildContext context) {
    Widget deleteNotificationBackgroundWidget =
        GetBuilder<NotificationsController>(
            builder: (NotificationsController controller) {
      return GestureDetector(
        onTap: () async {
          await Get.dialog(
            Container(
              color: ColorManager.black.withOpacity(0.1),
              height: 140.h,
              width: 140.w,
              child: Center(
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 18.w,
                  ),
                  child: DeleteNotificationDialogContent(
                    deleteNotificationFunction: () async {
                      await controller.deleteNotification(
                          notificationId: itemNotification.id ?? "");
                    },
                  ),
                ),
              ),
            ),
          );
        },
        child: Animator<double>(
            duration: const Duration(milliseconds: 1000),
            cycles: 0,
            curve: Curves.elasticIn,
            tween: Tween<double>(begin: 20.0, end: 25.0),
            builder: (context, animatorState, child) {
              return Container(
                width: 75.w,
                margin: EdgeInsets.only(right: 7.w),
                decoration: BoxDecoration(
                  color: ColorManager.red.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    ImagesManager.deleteIcon,
                    width: animatorState.value * 2.2,
                    height: animatorState.value * 1.4,
                  ),
                ),
              );
            }),
      );
    });
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 10.h, right: 5.w, left: 5.w, top: 5.h),
        child: Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            closeThreshold: 0.2,
            // dismissible: DismissiblePane(
            //   dismissThreshold: 0.2,
            //   onDismissed: () {},
            // ),
            dragDismissible: false,
            children: [deleteNotificationBackgroundWidget],
          ),
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                        itemNotification.notification?.data?.message ?? "",
                        fontWeight: FontWeightManager.softLight,
                        fontSize: 14.sp,
                        maxLines: 2,
                        textDirection: detectLang(
                                text: itemNotification
                                        .notification?.data?.message ??
                                    "")
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    PrimaryText(
                      itemNotification.notification!.creationTime!
                          .timeAgoCustom(),
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
        ),
      ),
    );
  }
}
