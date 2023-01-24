import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Stack(
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
            bottom: 65.h,
            left: 90.w,
            right: 90.w,
            child: PrimaryText(
              "${LocaleKeys.contentRight.tr}${DateTime.now().year.toString()}",
              fontSize: 14.sp,
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
                    SizedBox(height: 20.h),
                    PrimaryText(
                      LocaleKeys.hessaApp,
                      fontSize: 26.sp,
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
    );
  }
}
