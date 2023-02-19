import 'dart:developer';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/lotties_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../controllers/notifications_controller.dart';
import '../data/models/notification_data/item.dart';
import '../widgets/notification_widget.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.notifications.tr,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.fontColor,
              size: 20,
            ),
          ),
        ),
      ),
      body: GetX<NotificationsController>(
          builder: (NotificationsController controller) {
        if (controller.isInternetConnected.value == true) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              child: Column(
                children: [
                  GetBuilder<NotificationsController>(
                      builder: (NotificationsController controller) {
                    return Expanded(
                      child: RefreshIndicator(
                        color: ColorManager.white,
                        backgroundColor: ColorManager.primary,
                        onRefresh: () async => await Future.sync(
                            () => controller.pagingController.refresh()),
                        child: PagedListView<int, Item>(
                          pagingController: controller.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Item>(
                            animateTransitions: true,
                            transitionDuration:
                                const Duration(milliseconds: 350),
                            firstPageErrorIndicatorBuilder:
                                (BuildContext context) {
                              return Center(
                                child: SpinKitCircle(
                                  duration: const Duration(milliseconds: 1300),
                                  size: 50,
                                  color: ColorManager.primary,
                                ),
                              );
                            },
                            firstPageProgressIndicatorBuilder:
                                (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    LottiesManager.searchingLight,
                                    animate: true,
                                  ),
                                ],
                              );
                            },
                            newPageErrorIndicatorBuilder:
                                (BuildContext context) {
                              return Center(
                                child: SpinKitCircle(
                                  duration: const Duration(milliseconds: 1300),
                                  color: ColorManager.primary,
                                  size: 50,
                                ),
                              );
                            },
                            newPageProgressIndicatorBuilder:
                                (BuildContext context) {
                              return Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Center(
                                    child: SpinKitCircle(
                                      duration:
                                          const Duration(milliseconds: 1300),
                                      color: ColorManager.primary,
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              );
                            },
                            noItemsFoundIndicatorBuilder:
                                (BuildContext context) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        ImagesManager.noNotifications),
                                    SizedBox(height: 45.h),
                                    PrimaryText(
                                      LocaleKeys.no_notifications.tr,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeightManager.light,
                                    ),
                                    SizedBox(height: 10.h),
                                    PrimaryText(
                                      LocaleKeys
                                          .you_do_not_have_notifications_at_the_present_time
                                          .tr,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeightManager.light,
                                      color: ColorManager.fontColor7,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemBuilder: (BuildContext context,
                                Item notification, int index) {
                              return NotificationWidget(
                                iconPath: ImagesManager.checkIcon,
                                title:
                                    notification.notification?.data?.message ??
                                        "",
                                time: notification.notification!.creationTime!
                                    .timeAgoCustom(),
                                onTap: () async {
                                  log('notification clicked');
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.check_your_internet_connection.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeightManager.book,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: (Get.height * 0.5).h,
                  child: Lottie.asset(
                    LottiesManager.noInernetConnection,
                    animate: true,
                  ),
                ),
                PrimaryButton(
                  onPressed: () async {
                    await controller.checkInternet();
                  },
                  title: LocaleKeys.retry.tr,
                  fontSize: 16.sp,
                  width: (Get.width * 0.60).w,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
