import 'dart:developer';

import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/generated/locales.g.dart';
import 'package:hessa_student/global_presentation/global_features/lotties_manager.dart';
import 'package:lottie/lottie.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../controllers/notifications_controller.dart';
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
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.fontColor,
            size: 20,
          ),
        ),
      ),
      body: GetX<NotificationsController>(
          builder: (NotificationsController controller) {
        if (controller.isInternetConnected.value == true) {
          return RefreshIndicator(
            color: ColorManager.white,
            backgroundColor: ColorManager.primary,
            onRefresh: () async {},
            // onRefresh: () =>
            //     Future.sync(() => controller.pagingController.refresh()),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        NotificationWidget(
                          iconPath: ImagesManager.checkIcon,
                          title: "تم ارسال طلبك بنجاح",
                          time: "قبل 10 دقائق",
                          onTap: () async {
                            log('notification clicked');
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
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
