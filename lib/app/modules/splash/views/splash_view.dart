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
                )),
          ),
          Obx(
            () => Center(
              child: AnimatedScale(
                scale: controller.scale.value,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImagesManager.fullLogo),
                    SizedBox(
                      height: 20.h,
                    ),
                    PrimaryText(
                      LocaleKeys.hessaApp,
                      fontSize: 20.sp,
                      fontWeight: FontWeightManager.light,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 140.h,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
