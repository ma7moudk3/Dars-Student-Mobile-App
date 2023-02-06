import 'package:get/get.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/login/data/models/current_user_info/current_user_info.dart';

import '../../../routes/app_pages.dart';
import '../../login/data/repos/login_repo.dart';
import '../../login/data/repos/login_repo_implement.dart';

class SplashController extends GetxController {
  RxDouble positionBottom = Get.height.obs;
  RxDouble scale = 0.0.obs;
  final LoginRepo _loginRepo = LoginRepoImplement();
  CurrentUserInfo? currentUserInfo;

  @override
  void onInit() async {
    super.onInit();
    // CacheHelper.instance.setIsEmailAndPhoneConfirmed(false);
    // CacheHelper.instance.setAuthed(false);
    await Future.delayed(const Duration(milliseconds: 500), () async {
      positionBottom.value = 0;
      scale.value = 1;
    });
    await Future.delayed(const Duration(seconds: 2), () async {
      if (CacheHelper.instance.getFirstTimeOpenedApp()) {
        await Get.offNamed(Routes.ONBOARDING);
      } else {
        if (CacheHelper.instance.authenticated()) {
          await _getCurrentUserInfo().whenComplete(() async {
            if (CacheHelper.instance.getIsEmailAndPhoneConfirmed()) {
              await Get.offNamed(Routes.BOTTOM_NAV_BAR);
            } else {
              await Get.offNamed(Routes.VERIFY_ACCOUNT, arguments: {
                'isEmailConfirmed': currentUserInfo!.result!.isEmailConfirmed,
                'isPhoneNumberConfirmed':
                    currentUserInfo!.result!.isPhoneNumberConfirmed,
              });
            }
          });
        } else {
          await Get.offNamed(Routes.LOGIN_OR_SIGN_UP, arguments: {
            "isFromOnboarding": false,
          });
        }
      }
    });
  }

  Future _getCurrentUserInfo() async {
    currentUserInfo = await _loginRepo.getCurrentUserInfo();
  }
}
