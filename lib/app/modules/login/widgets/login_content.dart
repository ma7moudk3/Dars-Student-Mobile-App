import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginContent extends GetView<LoginController> {
  const LoginContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(() => LoginController());
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 28.h),
          width: 355.w,
          decoration: BoxDecoration(
            color: ColorManager.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: GetBuilder<LoginController>(
              builder: (LoginController controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryTextField(
                  cursorColor: ColorManager.primary,
                  focusNode: controller.emailFocusNode,
                  fontSize: 14.sp,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 25,
                    color: controller.emailFocusNode.hasFocus
                        ? controller.emailErrorIconColor ?? ColorManager.primary
                        : ColorManager.borderColor2,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  controller: controller.emailController,
                  title: LocaleKeys.email.tr,
                  hintText: LocaleKeys.enter_email.tr,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: ColorManager.borderColor2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: ColorManager.primary),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: ColorManager.red),
                  ),
                  borderSide: BorderSide(
                    color: controller.emailFocusNode.hasFocus
                        ? ColorManager.primary
                        : ColorManager.borderColor2,
                  ),
                  validator: (String? email) => controller.validateEmail(email),
                ),
                SizedBox(height: 28.h),
                PasswordTextField(
                  onFieldSubmitted: (String? value) async {
                    if (controller.formKey.currentState!.validate()) {
                      await checkInternetConnection(timeout: 5)
                          .then((bool internetStatus) async {
                        if (internetStatus == true) {
                          print('logged in');
                          // await controller.login();
                          Get.toNamed(Routes.BOTTOM_NAV_BAR); // for testing
                        } else {
                          await Get.toNamed(Routes.CONNECTION_FAILED);
                        }
                      });
                    }
                  },
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: ColorManager.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: ColorManager.borderColor2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: ColorManager.primary),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: controller.passwordFocusNode.hasFocus
                        ? controller.passwordErrorIconColor ??
                            ColorManager.primary
                        : ColorManager.grey,
                    size: 23.w,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: controller.passwordFocusNode.hasFocus
                        ? ColorManager.primary
                        : ColorManager.borderColor2,
                  ),
                  cursorColor: ColorManager.primary,
                  focusNode: controller.passwordFocusNode,
                  controller: controller.passwordController,
                  title: LocaleKeys.password.tr,
                  hintText: LocaleKeys.enter_password.tr,
                  validator: (String? value) =>
                      controller.validatePassword(value),
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async =>
                          await Get.toNamed(Routes.FORGOT_PASSWORD),
                      child: PrimaryText(
                        LocaleKeys.forgot_password,
                        color: ColorManager.fontColor,
                        fontWeight: FontWeightManager.softLight,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      await checkInternetConnection(timeout: 10)
                          .then((bool internetStatus) async {
                        if (internetStatus == true) {
                          print('logged in');
                          // await controller.login();
                          Get.toNamed(Routes.BOTTOM_NAV_BAR); // for testing
                        } else {
                          await Get.toNamed(Routes.CONNECTION_FAILED);
                        }
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(15.h),
                  title: LocaleKeys.login.tr,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 25.h),
                Visibility(
                  // visible: controller.countryCode.toLowerCase() == "ps" ||
                  //     controller.countryCode.toLowerCase() == "il" ||
                  //     controller.countryCode.toLowerCase() == "jo" ||
                  //     controller.countryCode.toLowerCase() == "eg",
                  visible: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Visibility(
                      //   visible: GetPlatform.isIOS,
                      //   child: Row(
                      //     children: [
                      //       SizedBox(width: 15.w),
                      //       GestureDetector(
                      //         behavior: HitTestBehavior.opaque,
                      //         onTap: () async {
                      //           if (await checkInternetConnection(
                      //               timeout: 10)) {
                      //             // apple login code
                      //           } else {
                      //             Get.toNamed(Routes.CONNECTION_FAILED);
                      //           }
                      //         },
                      //         child: Container(
                      //          height: 52.h,
                      //          width: 75.w,
                      //           decoration: BoxDecoration(
                      //             border: Border.all(
                      //                 width: 1, color: ColorManager.grey),
                      //             borderRadius: BorderRadius.circular(15),
                      //           ),
                      //           child: Center(
                      //             child: SvgPicture.asset(
                      //               ImagesManager.appleLogo,
                      //               height: 30.h,
                      //               width: 30.w,
                      //               color: isDarkMoodEnabled()
                      //                   ? ColorManager.white
                      //                   : null,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          if (await checkInternetConnection(timeout: 10)) {
                            // await controller.facebookLogin();
                          } else {
                            Get.toNamed(Routes.CONNECTION_FAILED);
                          }
                        },
                        child: Container(
                          height: 52.h,
                          width: 75.w,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: ColorManager.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              ImagesManager.facebookLogo,
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          if (await checkInternetConnection(timeout: 10)) {
                            // await controller.googleLogin();
                          } else {
                            Get.toNamed(Routes.CONNECTION_FAILED);
                          }
                        },
                        child: Container(
                          height: 52.h,
                          width: 75.w,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: ColorManager.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              ImagesManager.googleLogo,
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(
                      LocaleKeys.dont_have_an_account.tr,
                      color: ColorManager.fontColor,
                      fontWeight: FontWeightManager.softLight,
                      fontSize: 14.sp,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => ColorManager.primary.withOpacity(0.08)),
                      ),
                      onPressed: () async {
                        if (Get.previousRoute == Routes.SIGN_UP) {
                          Get.back();
                        } else {
                          await Get.toNamed(Routes.SIGN_UP);
                        }
                      },
                      child: PrimaryText(
                        LocaleKeys.sign_up_new_account.tr,
                        color: ColorManager.primary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                KeyboardVisibilityBuilder(
                    builder: (BuildContext context, bool isKeyboardVisible) {
                  return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      height: isKeyboardVisible ? Get.height * 0.13 : 0);
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
