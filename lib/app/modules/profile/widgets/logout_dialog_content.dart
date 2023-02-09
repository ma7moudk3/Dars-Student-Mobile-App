import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/global_button.dart';
import '../../../../global_presentation/global_widgets/loading.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../data/cache_helper.dart';
import '../../../data/network_helper/firebase_social_auth_helpers.dart';
import '../../../routes/app_pages.dart';

class LogoutDialogContent extends StatelessWidget {
  const LogoutDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImagesManager.exclamationMarkIcon),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.logout.tr,
              color: ColorManager.primary,
              fontSize: 20,
              fontWeight: FontWeightManager.medium,
            ),
            SizedBox(height: 10.h),
            PrimaryText(
              LocaleKeys.wanna_logout.tr,
              color: ColorManager.grey2,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalButton(
                  title: LocaleKeys.no.tr,
                  height: 50.h,
                  borderColor: ColorManager.primary,
                  width: 142.w,
                  onTap: () => Get.back(),
                ),
                SizedBox(width: 10.w),
                PrimaryButton(
                  width: 142.w,
                  onPressed: () async {
                    if (await checkInternetConnection(timeout: 10)) {
                      showLoadingDialog();
                      // await CacheHelper.instance.cacheLoggedInUser({});
                      await GoogleSignInHelper.googleLogout();
                      // await AppleSignInHelper.appleLogout();
                      // await FacebookSignInHelper.facebookLogout().then((value) {
                      //   if (Get.isDialogOpen!) {
                      //     Get.back();
                      //   }
                      // });
                      await CacheHelper.instance.setAccessToken("");
                      await CacheHelper.instance.setRefreshToken("");
                      await CacheHelper.instance.setFcmToken("");
                      await CacheHelper.instance.setUserProfilePicture("");
                      await FirebaseMessaging.instance.deleteToken();
                      await CacheHelper.instance.cacheCurrentUserInfo({});
                      await CacheHelper.instance
                          .cacheCurrentUserProfileInfo({});
                      await CacheHelper.instance.setAuthed(false);
                      await CacheHelper.instance.setIsEmailConfirmed(false);
                      await CacheHelper.instance.setIsPhoneConfirmed(false);
                      await Get.offAllNamed(Routes.LOGIN_OR_SIGN_UP);
                    } else {
                      await Get.toNamed(Routes.CONNECTION_FAILED);
                    }
                  },
                  title: LocaleKeys.ok.tr,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
