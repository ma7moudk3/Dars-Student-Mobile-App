import 'package:hessa_student/global_presentation/global_features/lotties_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/login_controller.dart';

class WelcomeBackDialogContent extends GetView<LoginController> {
  const WelcomeBackDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(
                  LocaleKeys.welcoming.tr,
                  color: ColorManager.primary,
                  fontSize: 18,
                  fontWeight: FontWeightManager.light,
                ),
                Get.locale!.languageCode != "ar"
                    ? SizedBox(
                        width: 5.w,
                      )
                    : const SizedBox.shrink(),
                Column(
                  children: [
                    Lottie.asset(
                      LottiesManager.hi,
                      width: 30.w,
                      animate: true,
                    ),
                    SizedBox(
                      height: Get.locale!.languageCode != "ar" ? 8.h : 12.h,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.welcome_back.tr,
              color: ColorManager.fontColor7,
              fontSize: 15,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              title: LocaleKeys.enjoy_the_app.tr,
              width: 160.w,
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
