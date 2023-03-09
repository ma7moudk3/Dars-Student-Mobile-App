import 'dart:math';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomNumber = random.nextInt(5) + 1;
    String splashBackground =
        "assets/images/splash_backgrounds/splash_background$randomNumber.png";
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(splashBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: HexColor.fromHex("#416FF4").withOpacity(0.60),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 15.h,
                  left: 100.w,
                  right: 100.w,
                  child: PrimaryText(
                    "${LocaleKeys.contentRight.tr}${DateTime.now().year.toString()}",
                    fontSize: 13,
                    fontWeight: FontWeightManager.light,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: (Get.height * 0.23).h,
                  left: 100.w,
                  right: 100.w,
                  child: Obx(
                    () => Center(
                      child: AnimatedScale(
                        scale: controller.scale.value,
                        duration: const Duration(milliseconds: 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImagesManager.fullLogo,
                            ),
                            SizedBox(height: 10.h),
                            PrimaryText(
                              LocaleKeys.darsApp,
                              fontSize: 24,
                              fontWeight: FontWeightManager.light,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5.h),
                            PrimaryText(
                              LocaleKeys.student,
                              fontSize: 20,
                              fontWeight: FontWeightManager.light,
                              color: Colors.white,
                            ),
                            SizedBox(height: 140.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
