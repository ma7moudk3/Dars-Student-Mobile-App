import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => AnimatedPositioned(
                bottom: controller.positionBottom.value,
                right: 0,
                duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset(
                  ImagesManager.splashBackground,
                  width: Get.width,
                ),
              ),
            ),
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
            Obx(
              () => Center(
                child: AnimatedScale(
                  scale: controller.scale.value,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImagesManager.fullLogo,
                        width: 95.w,
                        height: 95.h,
                      ),
                      SizedBox(height: 10.h),
                      PrimaryText(
                        LocaleKeys.hessaApp,
                        fontSize: 26.sp,
                        fontWeight: FontWeightManager.light,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.h),
                      PrimaryText(
                        LocaleKeys.student,
                        fontSize: 22.sp,
                        fontWeight: FontWeightManager.light,
                        color: Colors.white,
                      ),
                      SizedBox(height: 140.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
