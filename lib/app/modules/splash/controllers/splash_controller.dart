import 'package:get/get.dart';
import 'package:hessa_student/app/routes/app_pages.dart';

class SplashController extends GetxController {
  RxDouble positionBottom = Get.height.obs;
  RxDouble scale = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () async {
      positionBottom.value = 0;
      scale.value = 1;
    });
    Future.delayed(const Duration(milliseconds: 1700), () async {
      await Get.offAllNamed(Routes.ONBOARDING);
    });
  }
}
