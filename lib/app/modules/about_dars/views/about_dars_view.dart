import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_features/lotties_manager.dart';
import '../../../../global_presentation/global_widgets/custom_app_bar.dart';
import '../../../constants/exports.dart';
import '../controllers/about_dars_controller.dart';

class AboutDarsView extends GetView<AboutDarsController> {
  const AboutDarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.about_dars,
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
        action: const SizedBox.shrink(),
      ),
      body: GetX<AboutDarsController>(
          builder: (AboutDarsController controller) {
        if (controller.isInternetConnected.value) {
          if (controller.isLoading.value == false) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 82.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    SvgPicture.asset(
                      ImagesManager.darsLogo,
                      height: 100.h,
                      width: 100.w,
                    ),
                    SizedBox(height: 27.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1a000000),
                              offset: Offset(0, 1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              LocaleKeys.about_dars,
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.light,
                              color: ColorManager.primary,
                            ),
                            SizedBox(height: 14.h),
                            HtmlWidget(
                              Get.locale!.languageCode != "ar"
                                  ? controller.aboutDars.bodyF ?? ""
                                  : controller.aboutDars.bodyL ?? "",
                              textStyle: TextStyle(
                                color: ColorManager.fontColor,
                                fontSize: 15.sp,
                                letterSpacing: 0.5,
                                wordSpacing: 1.2,
                                fontWeight: FontWeightManager.softLight,
                                fontFamily: FontConstants.fontFamily,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                    LocaleKeys.follow_us,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeightManager.light,
                                    color: ColorManager.primary,
                                  ),
                                  SizedBox(height: 14.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                            ImagesManager.whatsappIcon),
                                      ),
                                      SizedBox(width: 12.w),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                            ImagesManager.instagramIcon),
                                      ),
                                      SizedBox(width: 12.w),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                            ImagesManager.facebookIcon),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
