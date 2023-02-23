import 'dart:developer';

import 'package:get/get.dart';
import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/cache_helper.dart';
import 'package:hessa_student/app/modules/splash/data/repos/splash_repo.dart';
import 'package:hessa_student/app/modules/splash/data/repos/splash_repo_implement.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../data/models/user_token/user_token.dart';

class SplashController extends GetxController {
  RxDouble positionBottom = Get.height.obs;
  RxDouble scale = 0.0.obs;
  final SplashRepo _splashRepo = SplashRepoImplement();
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 500), () async {
      positionBottom.value = 0;
      scale.value = 1;
    });
    bool isTokenExpired = isAccessTokenExpired();
    await Future.delayed(const Duration(milliseconds: 2000), () async {
      if (CacheHelper.instance.getFirstTimeOpenedApp()) {
        await Get.offNamed(Routes.ONBOARDING);
      } else {
        if (CacheHelper.instance.authenticated()) {
          log("isTokenExpired: $isTokenExpired");
          if (isTokenExpired) {
            await _splashRepo.refreshToken().then((UserToken userToken) async {
              if (userToken.result != null &&
                  userToken.result!.accessToken != null &&
                  CacheHelper.instance.getRefreshToken().isNotEmpty) {
                await CacheHelper.instance.setLoginTime(
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
                await CacheHelper.instance.setTokenExpirationSeconds(
                    userToken.result?.expireInSeconds ?? 0);
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
            });
          } else {
            if (CacheHelper.instance.getRefreshToken().isNotEmpty) {
              if (CacheHelper.instance.getIsEmailConfirmed() &&
                  CacheHelper.instance.getIsPhoneConfirmed()) {
                await Get.offNamed(Routes.BOTTOM_NAV_BAR);
              } else {
                await Get.offNamed(Routes.VERIFY_ACCOUNT);
              }
            }
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
