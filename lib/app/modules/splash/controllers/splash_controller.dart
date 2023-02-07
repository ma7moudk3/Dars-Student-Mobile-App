import 'package:get/get.dart';
import 'package:hessa_student/app/data/cache_helper.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  RxDouble positionBottom = Get.height.obs;
  RxDouble scale = 0.0.obs;

  @override
  void onInit() async {
    // CacheHelper.instance.setAuthed(false);
    // CacheHelper.instance.setIsEmailConfirmed(false);
    // CacheHelper.instance.setIsPhoneConfirmed(false);
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 500), () async {
      positionBottom.value = 0;
      scale.value = 1;
    });
    await Future.delayed(const Duration(seconds: 2), () async {
      if (CacheHelper.instance.getFirstTimeOpenedApp()) {
        await Get.offNamed(Routes.ONBOARDING);
      } else {
        if (CacheHelper.instance.authenticated()) {
          if (CacheHelper.instance.getIsEmailConfirmed() &&
              CacheHelper.instance.getIsPhoneConfirmed()) {
            await Get.offNamed(Routes.BOTTOM_NAV_BAR);
          } else {
            await Get.offNamed(Routes.VERIFY_ACCOUNT);
          }
        } else {
          await Get.offNamed(Routes.LOGIN_OR_SIGN_UP, arguments: {
            "isFromOnboarding": false,
          });
        }
      }
    });
  }
}
