import 'dart:developer';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hessa_student/app/modules/sign_up/controllers/sign_up_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global_presentation/global_widgets/intl_phone_number_widget.dart';
import '../../../constants/exports.dart';
import '../../../core/helper_functions.dart';
import '../../../routes/app_pages.dart';

class SignUpContent extends GetView<SignUpController> {
  const SignUpContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 1.4,
      child: Form(
        key: controller.formKey,
        child: Container(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 10.h),
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
          child: GetBuilder<SignUpController>(
              builder: (SignUpController controller) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PrimaryText(
                        LocaleKeys.gender,
                        color: ColorManager.fontColor,
                        fontWeight: FontWeightManager.light,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  PrimaryTextField(
                    cursorColor: ColorManager.primary,
                    focusNode: controller.fullNameFocusNode,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      size: 25,
                      color: controller.fullNameFocusNode.hasFocus
                          ? controller.fullNameErrorIconColor ??
                              ColorManager.primary
                          : ColorManager.borderColor2,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    controller: controller.fullNameController,
                    title: LocaleKeys.full_name.tr,
                    hintText: LocaleKeys.enter_full_name.tr,
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
                      color: controller.fullNameFocusNode.hasFocus
                          ? ColorManager.primary
                          : ColorManager.borderColor2,
                    ),
                    validator: (String? fullName) =>
                        controller.validateEmail(fullName),
                  ),
                  IntlPhoneNumberTextField(
                    controller: controller.phoneController,
                    focusNode: controller.phoneFocusNode,
                  ),
                  SizedBox(height: 10.h),
                  PrimaryTextField(
                    cursorColor: ColorManager.primary,
                    focusNode: controller.emailFocusNode,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 25,
                      color: controller.emailFocusNode.hasFocus
                          ? controller.emailErrorIconColor ??
                              ColorManager.primary
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
                    validator: (String? email) =>
                        controller.validateEmail(email),
                  ),
                  SizedBox(height: 10.h),
                  PasswordTextField(
                    onFieldSubmitted: (String? value) async {
                      if (controller.formKey.currentState!.validate()) {
                        await checkInternetConnection(timeout: 5)
                            .then((bool internetStatus) async {
                          if (internetStatus == true) {
                            log('sign up');
                            // await controller.login();
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
                    validator: (String? password) =>
                        controller.validatePassword(password),
                  ),
                  SizedBox(height: 10.h),
                  PasswordTextField(
                    onFieldSubmitted: (String? value) async {
                      if (controller.formKey.currentState!.validate()) {
                        await checkInternetConnection(timeout: 5)
                            .then((bool internetStatus) async {
                          if (internetStatus == true) {
                            log('sign up');
                            // await controller.login();
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
                      color: controller.confimationPasswordFocusNode.hasFocus
                          ? controller.confimationPasswordErrorIconColor ??
                              ColorManager.primary
                          : ColorManager.grey,
                      size: 23.w,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: controller.confimationPasswordFocusNode.hasFocus
                          ? ColorManager.primary
                          : ColorManager.borderColor2,
                    ),
                    cursorColor: ColorManager.primary,
                    focusNode: controller.confimationPasswordFocusNode,
                    controller: controller.confimationPasswordController,
                    title: LocaleKeys.confirm_password.tr,
                    hintText: LocaleKeys.confirm_password.tr,
                    validator: (String? confirmPassword) =>
                        controller.validateConfirmPassword(confirmPassword),
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => controller.toggleTermsOfUse(),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            border: !controller.tosIsAgreed
                                ? Border.all(
                                    color: ColorManager.borderColor2
                                        .withOpacity(0.5),
                                    width: 1,
                                  )
                                : null,
                            color: controller.tosIsAgreed
                                ? ColorManager.primary.withOpacity(0.2)
                                : null,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: (controller.tosIsAgreed)
                              ? Center(
                                  child: Icon(
                                    Icons.check,
                                    color: ColorManager.primary,
                                    size: 18,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PrimaryText(
                            LocaleKeys.agree_with,
                            color: ColorManager.fontColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeightManager.softLight,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.STATIC_PAGE, arguments: {
                                "pageTitle": LocaleKeys.terms_and_conditions.tr,
                                "pageId": Get.locale!.languageCode != "ar"
                                    ? 5267
                                    : 5267,
                              });
                            },
                            child: PrimaryText(
                              "${LocaleKeys.terms_and_conditions.tr} ",
                              color: ColorManager.primary,
                              fontSize: 13.sp,
                              fontWeight: FontWeightManager.softLight,
                            ),
                          ),
                          PrimaryText(
                            LocaleKeys.for_hessa,
                            color: ColorManager.fontColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeightManager.softLight,
                          ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () {

                      //   },
                      //   child: PrimaryText(
                      //     LocaleKeys.tos_agreed.tr,
                      //     color: ColorManager.grey8,
                      //     fontSize: 13,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        await checkInternetConnection(timeout: 10)
                            .then((bool internetStatus) async {
                          if (internetStatus == true) {
                            log('sign up');
                            // await controller.login();
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
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryText(
                        LocaleKeys.do_have_an_account.tr,
                        color: ColorManager.fontColor,
                        fontWeight: FontWeightManager.softLight,
                        fontSize: 14.sp,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  ColorManager.primary.withOpacity(0.08)),
                        ),
                        onPressed: () async => await Get.toNamed(Routes.LOGIN),
                        child: PrimaryText(
                          LocaleKeys.login.tr,
                          color: ColorManager.primary,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  KeyboardVisibilityBuilder(
                      builder: (BuildContext context, bool isKeyboardVisibile) {
                    if (isKeyboardVisibile) {
                      return SizedBox(height: 180.h);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
