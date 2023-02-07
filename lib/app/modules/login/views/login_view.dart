import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hessa_student/app/constants/exports.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_content.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesManager.loginBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: ColorManager.black.withOpacity(0.60),
          ),
        ),
        Scaffold(
          backgroundColor: ColorManager.transparent,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                KeyboardVisibilityBuilder(
                    builder: (BuildContext context, bool isKeyboardVisible) {
                  return Positioned(
                    right: 16.w,
                    top: isKeyboardVisible ? 25.h : 75.h,
                    child: Visibility(
                      visible: isKeyboardVisible
                          ? (Get.arguments != null &&
                                  Get.arguments['isFromLoginOrSignUp'] !=
                                      null &&
                                  Get.arguments['isFromLoginOrSignUp'])
                              ? false
                              : true
                          : true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PrimaryText(
                            LocaleKeys.do_your_sign_in,
                            fontSize: 18.sp,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.white,
                          ),
                          SizedBox(height: 5.h),
                          PrimaryText(
                            LocaleKeys.welcome_in_hessa_we_missed_you,
                            fontSize: 14.sp,
                            fontWeight: FontWeightManager.softLight,
                            color: ColorManager.white,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Visibility(
                    visible: Get.arguments != null &&
                        Get.arguments['isFromLoginOrSignUp'] != null &&
                        Get.arguments['isFromLoginOrSignUp'],
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
                  bottom: 55.h,
                  left: 18.w,
                  right: 18.w,
                  child: const LoginContent(),
                ),
                Positioned(
                  bottom: 15.h,
                  left: 105.w,
                  right: 105.w,
                  child: PrimaryText(
                    "${LocaleKeys.contentRight.tr}${DateTime.now().year.toString()}",
                    fontSize: 12.sp,
                    fontWeight: FontWeightManager.light,
                    color: Colors.white,
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
