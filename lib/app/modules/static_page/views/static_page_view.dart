import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/static_page_controller.dart';

class StaticPageView extends GetView<StaticPageController> {
  const StaticPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.pageTitle,
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
        action: const SizedBox.shrink(),
      ),
      body: GetX<StaticPageController>(
          builder: (StaticPageController controller) {
        if (controller.isInternetConnected.value) {
          if (controller.isLoading.value == false) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              ImagesManager.shieldIcon,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              controller.pageSubTitle,
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.light,
                            ),
                            SizedBox(height: 5.h),
                            PrimaryText(
                              "${LocaleKeys.last_updated.tr}: ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
                              fontSize: 12.sp,
                              fontWeight: FontWeightManager.light,
                              color: ColorManager.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    moreDivider(),
                    SizedBox(height: 10.h),
                    HtmlWidget(
                      Get.locale!.languageCode != "ar"
                          ? controller.contentManagement.bodyF ?? ""
                          : controller.contentManagement.bodyL ?? "",
                      textStyle: TextStyle(
                        color: ColorManager.fontColor,
                        fontSize: (16).sp,
                        fontWeight: FontWeightManager.light,
                        wordSpacing: 1.5,
                        height: 1.18,
                        letterSpacing: 0.5,
                        fontFamily: FontConstants.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: SpinKitCircle(
                duration: const Duration(milliseconds: 1300),
                size: 50,
                color: ColorManager.primary,
              ),
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.check_your_internet_connection.tr,
                  fontSize: 18,
                  fontWeight: FontWeightManager.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Get.height * 0.5,
                  child: Lottie.asset(
                    LottiesManager.noInernetConnection,
                    animate: true,
                  ),
                ),
                SizedBox(height: 10.h),
                PrimaryButton(
                  onPressed: () async {
                    await controller.checkInternet();
                  },
                  title: LocaleKeys.retry.tr,
                  width: Get.width * 0.5,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
