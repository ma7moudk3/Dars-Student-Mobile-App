import 'package:hessa_student/app/constants/exports.dart';
import 'package:hessa_student/app/routes/app_pages.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/login_or_sign_up_controller.dart';

class LoginOrSignUpView extends GetView<LoginOrSignUpController> {
  const LoginOrSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Stack(
        children: [
          GetBuilder<LoginOrSignUpController>(
            builder: (LoginOrSignUpController controller) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Container(
                  key: UniqueKey(),
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(controller.loginBackgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    color: ColorManager.black.withOpacity(0.60),
                  ),
                ),
              );
            },
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.transparent,
            body: SafeArea(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 108.w,
                    right: 108.w,
                    top: 65.h,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          ImagesManager.fullLogo,
                          width: 90.w,
                          height: 90.h,
                        ),
                        SizedBox(height: 20.h),
                        PrimaryText(
                          LocaleKeys.hessaApp,
                          fontSize: 26.sp,
                          fontWeight: FontWeightManager.light,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Visibility(
                      visible: Get.arguments != null &&
                          Get.arguments['isFromOnboarding'] != null &&
                          Get.arguments['isFromOnboarding'] == true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: ColorManager.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15.h,
                    left: 110.w,
                    right: 110.w,
                    child: PrimaryText(
                      "${LocaleKeys.contentRight.tr}${DateTime.now().year.toString()}",
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.light,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 70.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          PrimaryButton(
                            onPressed: () async {
                              await Get.toNamed(Routes.LOGIN);
                            },
                            borderRadius: BorderRadius.circular(15.h),
                            title: LocaleKeys.sign_in_now,
                          ),
                          SizedBox(height: 20.h),
                          PrimaryButton(
                            color: ColorManager.transparent,
                            onPressed: () async {
                              await Get.toNamed(Routes.SIGN_UP);
                            },
                            borderRadius: BorderRadius.circular(15.h),
                            title: LocaleKeys.sign_up_new_account,
                            borderSide: BorderSide(
                              color: ColorManager.white,
                              width: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
